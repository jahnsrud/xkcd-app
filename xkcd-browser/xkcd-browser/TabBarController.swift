import UIKit

final class TabBarController: UITabBarController {
    private enum Tab {
        case latest
        case browse
        case favorites
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTabs()
    }
    
    private func addTabs() {
        let viewControllers = [
            createBrowseVC()
        ]
        setViewControllers(viewControllers, animated: false)
    }
    
    private func createBrowseVC() -> UINavigationController {
        let vc = BrowseVC()
        vc.tabBarItem = UITabBarItem(
            title: "Browse",
            image: UIImage(systemName: "doc.text.image"),
            tag: 0
        )
        
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }
    
}
