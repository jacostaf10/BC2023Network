//
//  File.swift
//  
//
//  Created by Jorge Acosta Freire on 13/4/23.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum AuthorizationMethod: String {
    case token = "Bearer"
    case basic = "Basic"
}


public extension URLRequest {
    static func get(url: URL, token: String? = nil, authMethod: AuthorizationMethod = .token) -> URLRequest {
        var request = URLRequest(url: url)
        if let token {
            request.setValue("\(authMethod.rawValue) \(token)", forHTTPHeaderField: "Authorization")
        }
        request.timeoutInterval = 30
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    static func post<JSON: Codable>(url: URL, data: JSON, httpMethod: HTTPMethod = .post, token: String? = nil, authMethod: AuthorizationMethod = .token) -> URLRequest {
        var request = URLRequest(url: url)
        if let token {
            request.setValue("\(authMethod.rawValue) \(token)", forHTTPHeaderField: "Authorization")
        }
        request.timeoutInterval = 30
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        
        return request
    }
}
