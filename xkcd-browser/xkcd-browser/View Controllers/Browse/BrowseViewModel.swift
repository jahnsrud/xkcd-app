import Foundation
import Combine
import NetworkingKit

final class BrowseViewModel {
    @Published var comicItems = [Comic]()

    private var cancellables = Set<AnyCancellable>()
    private let xkcdService = XKCDService(httpClient: HTTPClient())
    private var newestComicNum: Int?
    private let numberOfComicsToFetch = 10
    
    init() {
        Task {
            await loadContent()
        }
    }
    
    // MARK: User Actions
    
    func didPullToRefresh() {
        comicItems.removeAll()
        Task {
            await loadContent()
        }
    }
    
    // MARK: Load Content
    
    private func loadContent() async {
        do {
            let firstComic = try await xkcdService.fetchFirstComic()
            comicItems.append(firstComic)
            newestComicNum = firstComic.num
            await fetch(numberOfComics: numberOfComicsToFetch)
        } catch {
            print("Something went wrong: \(error.localizedDescription)")
        }
    }
    
    private func fetch(numberOfComics number: Int) async {
        for index in (newestComicNum!-number..<newestComicNum!).reversed() {
            await fetchComic(number: index)
        }
    }

    private func fetchComic(number: Int) async {
        do {
            let comic = try await xkcdService.fetchComic(number: number)
            self.comicItems.append(comic)
        } catch {
            print("Something went wrong: \(error.localizedDescription)")
        }
    }
}
