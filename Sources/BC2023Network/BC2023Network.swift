import SwiftUI

public final class BCNetwork {
    
    public static let shared = BCNetwork()
    
    public func getJSON<JSON: Codable>(request: URLRequest, type: JSON.Type, decoder: JSONDecoder = JSONDecoder()) async throws -> JSON {
        let (data, response) = try await URLSession.shared.dataRequest(for: request)
        guard let res = response as? HTTPURLResponse else {throw NetworkError.noHTTP}
        if res.statusCode == 200 {
            do {
                return try decoder.decode(JSON.self, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(res.statusCode)
        }
    }
    
    public func post(request: URLRequest, statusOK: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.dataRequest(for: request)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noHTTP}
        if response.statusCode != statusOK {
            throw NetworkError.status(response.statusCode)
        }
    }
    #if os(iOS)
    public func getImage(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.dataRequest(from: url)
        guard let res = response as? HTTPURLResponse else {throw NetworkError.noHTTP}
        if res.statusCode == 200 {
            if let image = UIImage(data: data) {
                return image
            } else {
                throw NetworkError.dataNotValid
            }
            
        } else {
            throw NetworkError.status(res.statusCode)
        }
    }
    #endif
    
}
