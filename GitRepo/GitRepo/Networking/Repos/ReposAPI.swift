//
//  ReposAPI.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import UIKit

protocol ReposAPIProtocol {
    func list(completion: @escaping (Result<[RepositoryModel], ErrorResponse>) -> Void)
}

class ReposAPI: NetworkEngine<ReposNetworking>, ReposAPIProtocol {
    func list(completion: @escaping (Result<[RepositoryModel], ErrorResponse>) -> Void) {
        self.request(target: .list) { (result: Result<[RepositoryModel], ErrorResponse>) in
            switch result {
            case .success(let response):
            completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
