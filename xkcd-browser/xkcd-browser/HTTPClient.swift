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
                let comicDTO = try JSONDecoder().decode(ComicDTO.self, from: data)
                
                print(comicDTO.title)
                print(comicDTO.alt)
                print(comicDTO.img)
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        
        
        
    }
}
