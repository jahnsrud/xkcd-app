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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.textAlignment = .center
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
        setContent()
    }
    
    private func addViews() {
        view.addAutoLayoutView(descriptionLabel)
        view.addAutoLayoutView(dateLabel)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UserInterface.horizontalMargin),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UserInterface.horizontalMargin),

            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UserInterface.horizontalMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UserInterface.horizontalMargin),
        ])
    }
    
    private func setupNavigationBar() {
        let closeBarButtonItem = UIBarButtonItem(
            title: "button.close".localized,
            image: UIImage(systemName: "xmark.circle"),
            primaryAction: UIAction(handler: { [weak self] _ in
                self?.dismiss(animated: true)
            })
        )
        navigationItem.setRightBarButton(closeBarButtonItem, animated: false)
    }
    
    private func setContent() {
        descriptionLabel.text = comic.alt
        dateLabel.text = comic.date?.formatted(date: .numeric, time: .omitted)
    }
}
