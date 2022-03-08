import UIKit

protocol TabBarRootView {
    func scrollToTop()
}

final class TabBarController: UITabBarController {
    private enum Tab {
        case latest
        case browse
        case favorites
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        addTabs()
    }
    
    private func addTabs() {
        let viewControllers = [
            createBrowseVC()
        ]
        setViewControllers(viewControllers, animated: false)
    }
    
    private func createBrowseVC() -> UINavigationController {
        let vc = BrowseViewController()
        vc.tabBarItem = UITabBarItem(
            title: "browse.title".localized,
            image: UIImage(systemName: "doc.text.image"),
            tag: 0
        )
        
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedViewController == viewController {
            guard let navigationController = viewController as? UINavigationController else {
                return true
            }
            guard navigationController.viewControllers.count <= 1, let handler = navigationController.viewControllers.first as? TabBarRootView else {
                return true
            }
            handler.scrollToTop()
        }
        return true
    }
}
