import UIKit

extension UIView {
    func addAutoLayoutView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
