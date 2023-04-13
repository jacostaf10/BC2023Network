import Foundation

public final class BCNetwork {
    
    public static let shared = BCNetwork()
    
    public func getJSON<JSON: Codable>(request: URLRequest, type: JSON.Type) async throws -> JSON {
        let (data, response) = try await URLSession.shared.dataRequest(for: request)
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
    
    public func postJSON<JSON: Codable> (request: URLRequest, json: JSON, statusOK: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.dataRequest(for: request)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noHTTP}
        if response.statusCode != statusOK {
            throw NetworkError.status(response.statusCode)
        }
    }
    
}
