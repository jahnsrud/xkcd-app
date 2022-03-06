import UIKit

final class BrowseVC: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let placeholderReadMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Detail View [beta]", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "browse.title".localized
        view.backgroundColor = .systemBackground
        addViews()
        addConstraints()
        setupTableView()
        
        placeholderReadMoreButton.addAction(UIAction(handler: { _ in
            let vc = ComicDetailVC()
            let navController = UINavigationController(rootViewController: vc)
            navController.sheetPresentationController?.detents = [.medium(), .large()]
            self.present(navController, animated: true)
        }), for: .primaryActionTriggered)
        
    }

    private func addViews() {
        view.addAutoLayoutView(tableView)
        view.addAutoLayoutView(placeholderReadMoreButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            placeholderReadMoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderReadMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isPagingEnabled = true
        tableView.allowsSelection = false
    }
    
}
extension BrowseVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
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

extension BrowseVC: UITableViewDelegate {
   
}
