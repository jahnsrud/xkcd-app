import Foundation
import Combine
import NetworkingKit

final class BrowseViewModel {
    private let httpClient = HTTPClient()

    @Published var comicItems = [Comic]()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchComics()
    }
    
    private func fetchComics() {
        httpClient.fetch(from: URL(string: "https://xkcd.com/info.0.json")!)
        
        // TODO: remove
        self.comicItems = [
            Comic(num: 0, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.nrk.no")!, transcript: "Forklaring"),
            Comic(num: 1, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.vg.no")!, transcript: "Forklaring")
        ]
    }
    
    // MARK: User Actions
    
    func didPullToRefresh() {
        comicItems.removeAll()
        fetchComics()
    }
    
}
