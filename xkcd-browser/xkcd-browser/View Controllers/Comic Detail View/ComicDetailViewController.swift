import UIKit

final class ComicDetailViewController: UIViewController {
    private let comic: Comic
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(comic: Comic) {
        self.comic = comic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not available")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = comic.title
        view.backgroundColor = .systemBackground

        addViews()
        addConstraints()
        setupNavigationBar()
        
        descriptionLabel.text = comic.alt
        dateLabel.text = comic.date?.formatted(date: .numeric, time: .omitted)
    }
    
    private func addViews() {
        view.addAutoLayoutView(descriptionLabel)
        view.addAutoLayoutView(dateLabel)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UserInterface.horizontalMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UserInterface.horizontalMargin),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
        ])
    }
    
    private func setupNavigationBar() {
        let closeBarButtonItem = UIBarButtonItem(
            title: "button.close".localized,
            image: UIImage(systemName: "xmark.circle"),
            primaryAction: UIAction(handler: { _ in
                self.dismiss(animated: true)
            })
        )
        navigationItem.setRightBarButton(closeBarButtonItem, animated: false)
    }
    
}
