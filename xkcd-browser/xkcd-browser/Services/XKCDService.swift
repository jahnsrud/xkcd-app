import Foundation
import NetworkingKit

/// API Explanation:
/// Get latest: https://xkcd.com/info.0.json
/// Get specific: https://xkcd.com/-num-/info.0.json

final class XKCDService {
    private let httpClient: HTTPClient

    private let latestUrl = URL(string: "https://xkcd.com/info.0.json")!
    private var newestComicNum: Int?
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    public func fetchFirstComic() async throws -> Comic {
        do {
            let data = try await httpClient.fetch(from: latestUrl)
            let comic = try JSONDecoder().decode(ComicDTO.self, from: data)
            return comic.toModel()
        } catch {
            throw error
        }
    }
    
    public func fetchComic(number: Int) async throws -> Comic {
        let url = URL(string: "https://xkcd.com/\(number)/info.0.json")!
        
        do {
            let data = try await httpClient.fetch(from: url)
            let comic = try JSONDecoder().decode(ComicDTO.self, from: data)
            return comic.toModel()
        } catch {
            throw error
        }
    }
}
