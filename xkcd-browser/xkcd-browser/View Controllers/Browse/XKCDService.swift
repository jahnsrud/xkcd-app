import Foundation
import NetworkingKit

/// API Explanation:
/// Get latest: https://xkcd.com/info.0.json
/// Get specific: https://xkcd.com/-num-/info.0.json

final class XKCDService {
    private let httpClient = HTTPClient()
    private let latestUrl = URL(string: "https://xkcd.com/info.0.json")!
    private var newestComicNum: Int?
    
    public func fetchFirstComic(completion: @escaping (Result<Comic, Error>) -> Void) {
        httpClient.fetch(from: latestUrl) { result in
            do {
                switch result {
                case .success(let data):
                    let comic = try JSONDecoder().decode(ComicDTO.self, from: data)
                    completion(.success(comic.toModel()))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func fetchComic(number: Int, completion: @escaping (Result<Comic, Error>) -> Void) {
        let url = URL(string: "https://xkcd.com/\(number)/info.0.json")!
        
        httpClient.fetch(from: url) { result in
            do {
                switch result {
                case .success(let data):
                    let comic = try JSONDecoder().decode(ComicDTO.self, from: data)
                    completion(.success(comic.toModel()))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
