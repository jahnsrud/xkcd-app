import UIKit
import NetworkingKit

final class FullHeightComicCell: UITableViewCell {
    private enum Constants {
        static let bottomMargin = 22.0
        static let labelMargin = 6.0
        static let imageToLabelMargin = 16.0
        static let topMargin = 8.0
        static let numberOfLines = 2
    }
    
    private let comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemIndigo
        label.numberOfLines = Constants.numberOfLines
        return label
    }()
    
    private let httpClient = HTTPClient()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: FullHeightComicCell.id)
        backgroundColor = .init(named: "Background")
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addAutoLayoutView(comicImageView)
        contentView.addAutoLayoutView(titleLabel)
        contentView.addAutoLayoutView(descriptionLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            comicImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: Constants.topMargin),
            comicImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UserInterface.horizontalMargin),
            comicImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UserInterface.horizontalMargin),
            comicImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.imageToLabelMargin),

            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -Constants.labelMargin),
            titleLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),

            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.bottomMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UserInterface.horizontalMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UserInterface.horizontalMargin)
        ])
    }
    
    func setComic(_ comic: Comic) {
        titleLabel.text = comic.title
        descriptionLabel.text = comic.alt ?? comic.formattedNumber
        updateImage(url: comic.imageUrl)
    }
    
    private func updateImage(url: URL) {
        httpClient.fetch(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.comicImageView.image = UIImage(data: data)
                case .failure:
                    self.comicImageView.image = nil
                }
            }
        }
    }
}
