import UIKit
import NetworkingKit

final class FullHeightComicCell: UITableViewCell {
    
    private enum Constants {
        static let bottomMargin = 16.0
        static let horizontalMargin = 20.0
        static let numberOfLines = 2
    }
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = Constants.numberOfLines
        return label
    }()
    
    private let httpClient = HTTPClient()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: FullHeightComicCell.id)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addAutoLayoutView(contentImageView)
        contentView.addAutoLayoutView(titleLabel)
        contentView.addAutoLayoutView(descriptionLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -Constants.bottomMargin),
            titleLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.bottomMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalMargin),
            
        ])
    }
    
    func setComic(_ comic: Comic) {
        titleLabel.text = comic.title
        descriptionLabel.text = comic.alt ?? comic.formattedNumber
        
        httpClient.fetch(from: comic.imageUrl) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.contentImageView.image = UIImage(data: data)
                case .failure:
                    self.contentImageView.image = nil
                }
            }
        }
    }
    
}
