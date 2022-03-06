import Foundation

struct ComicDTO: Codable {
    let day: String
    let month: String
    let year: String
    let num: Int
    let link: String?
    let news: String?
    let title: String
    let safe_title: String?
    let transcript: String?
    let alt: String
    let img: String
}

extension ComicDTO {
    func toModel() -> Comic {
        Comic(
            num: self.num,
            date: convertToDate(),
            title: self.title,
            link: self.link,
            alt: self.alt,
            imageUrl: URL(string: self.img)!,
            transcript: self.transcript
        )
    }
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fullDate = "\(year)-\(month)-\(day)"
        return dateFormatter.date(from: fullDate)
    }
}
