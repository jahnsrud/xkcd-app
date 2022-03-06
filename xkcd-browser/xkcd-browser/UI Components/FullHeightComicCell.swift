import UIKit

final class FullHeightComicCell: UITableViewCell {

    private enum Constants {
        static let BottomMargin = 16.0
        static let HorizontalMargin = 20.0
    }
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bookmark.circle.fill"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title.todo"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description.todo"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TODO_FIX")
        contentView.addAutoLayoutView(contentImageView)
        contentView.addAutoLayoutView(titleLabel)
        contentView.addAutoLayoutView(descriptionLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -Constants.BottomMargin),
            titleLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.BottomMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.HorizontalMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.HorizontalMargin),
            
        ])
    }

}
