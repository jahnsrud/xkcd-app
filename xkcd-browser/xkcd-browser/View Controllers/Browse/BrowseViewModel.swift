import Foundation
import Combine
import NetworkingKit

final class BrowseViewModel {
    private let httpClient = HTTPClient()

    @Published var comicItems = [Comic]()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchFirstComic()
    }
    
    // TODO: Move to dedicated service
    
    // API Explanation:
    // Get latest: https://xkcd.com/info.0.json
    // Get specific: https://xkcd.com/-num-/info.0.json
    
    private let latestUrl = URL(string: "https://xkcd.com/info.0.json")!
    private var newestComicNum: Int?
    
    private func fetchFirstComic() {
        httpClient.fetch(from: latestUrl) { result in
            switch result {
            case .success(let data):
                self.parseFirst(data: data)
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchComic(number: Int) {
        let url = URL(string: "https://xkcd.com/\(number)/info.0.json")!
        
        httpClient.fetch(from: url) { result in
            switch result {
            case .success(let data):
                self.parseResults(data: data)
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    private func parseFirst(data: Data) {
        do {
            let comics = try JSONDecoder().decode(ComicDTO.self, from: data)
            self.comicItems.append(comics.toModel())
            self.newestComicNum = comics.num

            for index in (newestComicNum!-5..<newestComicNum!).reversed() {
                self.fetchComic(number: index)
            }
            
        } catch {
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
        fetchFirstComic()
    }
    
}
