import UIKit
import Combine

final class BrowseViewController: UIViewController {
    private let viewModel = BrowseViewModel()
    private var comicItems = [Comic]()
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "browse.title".localized
        view.backgroundColor = .systemBackground
        addViews()
        addConstraints()
        setupTableView()
        setupViewModel()
        setupNavigationBar()
    }
    
    private func addViews() {
        view.addAutoLayoutView(tableView)
    }
    
    private func addConstraints() {
        view.pinViewToSafeArea(tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isPagingEnabled = true
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.registerCells(FullHeightComicCell.self)
        refreshControl.addAction(UIAction(handler: { _ in
            self.viewModel.didPullToRefresh()
        }), for: .valueChanged)
    }
    
    private func setupViewModel() {
        viewModel.$comicItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.comicItems = items
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                self?.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)
    }
    
    private func setupNavigationBar() {
        let shareButton = UIBarButtonItem(
            systemItem: .action, primaryAction: UIAction(handler: { _ in
                self.presentShareView()
            })
        )
        navigationItem.setRightBarButton(shareButton, animated: false)
    }
    
    private func presentShareView() {
        guard let visibleComic = visibleComic else {
            return
        }
        let activityVC = UIActivityViewController(
            activityItems: [visibleComic.imageUrl],
            applicationActivities: nil
        )
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }
    
    private func presentDetailView(for comic: Comic) {
        let vc = ComicDetailViewController(comic: comic)
        let navController = UINavigationController(rootViewController: vc)
        navController.sheetPresentationController?.detents = [.medium(), .large()]
        self.present(navController, animated: true)
    }
    
    private var visibleComic: Comic? {
        let visibleIndexPath = tableView.indexPathsForVisibleRows?.first
        return comicItems[visibleIndexPath!.row]
    }
    
}
extension BrowseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comic = comicItems[indexPath.row]
        let cell = FullHeightComicCell()
        cell.setComic(comic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

extension BrowseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedComic = comicItems[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        presentDetailView(for: selectedComic)
    }
}

extension BrowseViewController: TabBarRootView {
    func scrollToTop() {
        tableView.scrollToRow(
            at: IndexPath(row: 0, section: 0),
            at: .top,
            animated: true
        )
    }
}
