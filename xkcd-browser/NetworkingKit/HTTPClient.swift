import Foundation

struct HTTPClient {
    
    func fetch(from url: URL) {
        
        // TODO: try Combine
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                // TODO: Handle
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        
        
    }
}
