import UIKit

final class BrowseVC: UIViewController {

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Coming soon"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addAutoLayoutView(placeholderLabel)
    }
    
}
