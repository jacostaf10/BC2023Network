//
//  File.swift
//  
//
//  Created by Jorge Acosta Freire on 17/3/23.
//

import Foundation

public extension URLSession {
    func dataRequest(from url: URL) async throws -> (Data, URLResponse) {
        do {
            return try await data(from: url)
        } catch {
            throw NetworkError.general(error)
        }
    }
}


public enum NetworkError: Error, CustomStringConvertible {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case noHTTP
    case unknown
    
    public var description: String {
        switch self {
        case .general(let error):
            return "Error general \(error.localizedDescription)"
        case .status(let int):
            return "Status code \(int)"
        case .json(let error):
            return "Error de JSON \(error)"
        case .dataNotValid:
            return "Data Not Valid"
        case .noHTTP:
            return "No es conexion HTTP"
        case .unknown:
            return "Desconocido"
        }
    }
}
