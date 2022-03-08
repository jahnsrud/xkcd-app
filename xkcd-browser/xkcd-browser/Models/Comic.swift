import Foundation

struct Comic {
    let num: Int
    let date: Date?
    let title: String
    let imageUrl: URL
    let link: String?
    let alt: String?
    let news: String?
    let transcript: String?
}

extension Comic {
    var formattedNumber: String {
        "# \(num)"
    }
}
