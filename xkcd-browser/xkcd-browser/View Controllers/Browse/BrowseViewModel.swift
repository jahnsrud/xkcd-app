import Foundation
import Combine

final class BrowseViewModel {
    
    @Published var comicItems = [Comic]()
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.comicItems = [
            Comic(num: 0, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.nrk.no")!),
            Comic(num: 1, link: "coming_soon", title: "coming_soon", imageUrl: URL(string: "https://www.vg.no")!),
        ]
    }
    
    private func fetchComics() {
        
    }
    
    // MARK: User Actions
    
    
}
