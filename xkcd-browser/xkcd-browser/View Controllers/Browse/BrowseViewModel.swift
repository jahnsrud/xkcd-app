import Foundation
import Combine

final class BrowseViewModel {
    @Published var comicItems = [Comic]()
    private var cancellables = Set<AnyCancellable>()
    private let xkcdService = XKCDService()
    private var newestComicNum: Int?
    private let numberOfComicsToFetch = 10
    
    init() {
        loadContent()
    }
    
    private func loadContent() {
        xkcdService.fetchFirstComic { result in
            switch result {
            case .success(let comic):
                self.comicItems.append(comic)
                self.newestComicNum = comic.num
                self.fetch(numberOfComics: self.numberOfComicsToFetch)
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetch(numberOfComics number: Int) {
        for index in (newestComicNum!-number..<newestComicNum!).reversed() {
            self.fetchComic(number: index)
        }
    }

    private func fetchComic(number: Int) {
        xkcdService.fetchComic(number: number) { result in
            switch result {
            case .success(let comic):
                self.comicItems.append(comic)
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }

    // MARK: User Actions
    
    func didPullToRefresh() {
        comicItems.removeAll()
        loadContent()
    }
    
}
