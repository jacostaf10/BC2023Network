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



public extension URLRequest {
    public static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    public static func post<JSON: Codable>(url: URL, data: JSON, httpMethod: HTTPMethod = .post) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        
        return request
    }
}
