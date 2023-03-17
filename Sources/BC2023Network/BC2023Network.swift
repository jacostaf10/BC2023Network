import Foundation

public final class BCNetwork {
    
    public static let shared = BCNetwork()
    
    public func getJSON<JSON: Codable>(url: URL, type: JSON.Type) async throws -> JSON {
        let (data, response) = try await URLSession.shared.dataRequest(from: url)
        guard let res = response as? HTTPURLResponse else {throw NetworkError.noHTTP}
        if res.statusCode == 200 {
            do {
                return try JSONDecoder().decode(JSON.self, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(res.statusCode)
        }
    }
    
    
}
