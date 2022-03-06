import Foundation

struct Comic {
    /* let day: String
    let month: String
    let year: String */
    let num: Int
    let link: String?
    // let news: String?
    let title: String
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
