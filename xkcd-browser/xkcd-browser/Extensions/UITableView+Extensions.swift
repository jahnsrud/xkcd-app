import UIKit

extension UITableView {
    func registerCells(_ cells: UITableViewCell.Type...) {
        for cell in cells {
            register(cell, forCellReuseIdentifier: cell.id)
        }
    }
}

extension UITableViewCell {
    static var id: String {
        return String(describing: self)
    }
}
