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
        let url = URL(string: "https://xkcd.com/info.0.json")!
        
        // API:
        // Get latest: https://xkcd.com/info.0.json
        // Get specific: https://xkcd.com/-num-/info.0.json
        
        httpClient.fetch(from: url) { result in
            switch result {
            case .success(let data):
                self.parseResults(data: data)
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    private func parseResults(data: Data) {
        do {
            let comics = try JSONDecoder().decode(ComicDTO.self, from: data)
            self.comicItems.append(comics.toModel())
        } catch {
        }
    }
    
    // MARK: User Actions
    
    func didPullToRefresh() {
        comicItems.removeAll()
        fetchComics()
    }
    
}
