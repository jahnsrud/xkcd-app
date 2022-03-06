import UIKit

final class ComicDetailViewController: UIViewController {
    
    private enum Constants {
        static let HorizontalMargin = 20.0
    }
    
    private let comic: Comic
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
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
        self.title = comic.title
        view.backgroundColor = .systemBackground
        
        view.addAutoLayoutView(descriptionLabel)
        view.addAutoLayoutView(dateLabel)
        
        descriptionLabel.text = comic.transcript
        dateLabel.text = comic.date?.formatted()
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.HorizontalMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.HorizontalMargin),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
}
