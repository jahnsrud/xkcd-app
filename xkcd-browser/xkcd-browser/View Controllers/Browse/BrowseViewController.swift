import UIKit
import Combine

final class BrowseViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let refreshControl = UIRefreshControl()
    
    private var comicItems = [Comic]()
    private let viewModel = BrowseViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "browse.title".localized
        view.backgroundColor = .systemBackground
        addViews()
        addConstraints()
        setupTableView()
        setupViewModel()
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
        tableView.register(FullHeightComicCell.self, forCellReuseIdentifier: "TODO_FIX")
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
    
    private func presentDetailView(for comic: Comic) {
        let vc = ComicDetailViewController(comic: comic)
        let navController = UINavigationController(rootViewController: vc)
        navController.sheetPresentationController?.detents = [.medium(), .large()]
        self.present(navController, animated: true)
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
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .gray
        } else {
            cell.backgroundColor = .lightGray
        }
        
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