//
//  ReposAPI.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import UIKit

protocol ReposAPIProtocol {
    func list(completion: @escaping (Result<[RepositoryModel], NSError>) -> Void)
}

class ReposAPI: NetworkEngine<ReposNetworking>, ReposAPIProtocol {
    func list(completion: @escaping (Result<[RepositoryModel], NSError>) -> Void) {
        self.request(target: .list) { (result: Result<[RepositoryModel], Error>) in
            switch result {
            case .success(let response):
            completion(.success(response))
            case .failure(let error):
                completion(.failure(error as NSError))
            }
        }
    }
}
