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
    
    public func postJSON<JSON: Codable> (url: URL, json: JSON, method: HTTPMethod = .post, statusOK: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.data(for: .post(url: url, data: json, httpMethod: .put))
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noHTTP}
        if response.statusCode != statusOK {
            throw NetworkError.status(response.statusCode)
        }
    }
    
}
