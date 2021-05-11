//
//  HTTPMethod.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var params: [String:Any] { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}
