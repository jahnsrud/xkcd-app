import UIKit

final class ComicDetailVC: UIViewController {
    
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
        title = "Description"
        view.backgroundColor = .systemBackground
        
        view.addAutoLayoutView(descriptionLabel)
        view.addAutoLayoutView(dateLabel)
        
        descriptionLabel.text = comic.transcript
        dateLabel.text = "00/00/0000"
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
}
