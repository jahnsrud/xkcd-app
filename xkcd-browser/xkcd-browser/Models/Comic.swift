import Foundation

struct Comic {
    let num: Int
    let date: Date?
    let title: String
    let link: String?
    let alt: String?
    // let news: String?
    // let safe_title: String?
    // let alt: String
    let imageUrl: URL
    let transcript: String?
}

extension Comic {
    var formattedNumber: String {
        "# \(num)"
    }
}
