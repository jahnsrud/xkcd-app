import Foundation

struct ComicDTO: Codable {
    let day: String
    let month: String
    let year: String
    let num: Int
    let link: String?
    let news: String?
    let title: String
    let safe_title: String? // TODO: correct formatting
    let transcript: String?
    let alt: String
    let img: String
}

extension ComicDTO {
    func toModel() -> Comic {
        Comic(
            num: self.num,
            link: self.link,
            title: self.title,
            imageUrl: URL(string: self.img)!
            )
    }
}
