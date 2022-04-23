import Foundation

public struct HTTPClient {
    private static let session = URLSession.shared
    
    public init() {}
    
    public func fetch(from url: URL) async throws -> Data {
        let (data, _) = try await HTTPClient.session.data(from: url)
        return data
    }
}
