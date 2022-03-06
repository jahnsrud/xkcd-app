import UIKit

final class BrowseVC: UIViewController {

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Coming soon"
        return label
    }()
    
    private let placeholderReadMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Detail View [beta]", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addViews()
        addConstraints()
        
        placeholderReadMoreButton.addAction(UIAction(handler: { _ in
            let vc = ComicDetailVC()
            let navController = UINavigationController(rootViewController: vc)
            navController.sheetPresentationController?.detents = [.medium(), .large()]
            self.present(navController, animated: true)
        }), for: .primaryActionTriggered)
        
    }
    
    private func addViews() {
        view.addAutoLayoutView(placeholderLabel)
        view.addAutoLayoutView(placeholderReadMoreButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            placeholderReadMoreButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
