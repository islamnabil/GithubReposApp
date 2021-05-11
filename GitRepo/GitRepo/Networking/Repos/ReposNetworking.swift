//
//  ReposNetworking.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import Foundation

enum ReposNetworking {
    case list
    case details(path:String)
}

extension ReposNetworking:TargetType {
    
    
    var baseURL: String {
        return "\(Domain.url)"
    }
    
    var path: String {
        switch self {
        case .list:
            return "repositories"
        case .details(let path):
            return "repos/\(path)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list, .details:
            return .get
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .list, .details:
            return ["":""]
        }
    }
    
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                "Accept":"application/json"
            ]
        }
    }
    
    
}
