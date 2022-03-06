import Foundation

public struct HTTPClient {
    
    public init() {}

    public func fetch(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        })
        
        task.resume()
    }
}
