import Foundation
import Combine
import NetworkingKit

final class BrowseViewModel {
    private let httpClient = HTTPClient()

    @Published var comicItems = [Comic]()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.comicItems = [
            Comic(num: 0, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.nrk.no")!),
            Comic(num: 1, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.vg.no")!),
        ]
    }
    
    private func fetchComics() {
        httpClient.fetch(from: URL(string: "https://xkcd.com/info.0.json")!)
    }
    
    // MARK: User Actions
    
    func didPullToRefresh() {
        comicItems.removeAll()
        fetchComics()
        self.comicItems = [
            Comic(num: 0, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.nrk.no")!),
            Comic(num: 1, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.vg.no")!),
        ]
        
    }
    
}
