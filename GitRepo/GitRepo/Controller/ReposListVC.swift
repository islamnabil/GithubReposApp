//
//  ReposListVC.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import UIKit

class ReposListVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        img.getImage(from: "https://avatars.githubusercontent.com/u/1?v=4")
        
        NetworkEngine.request(url: URL(string: "https://api.github.com/repositories")!, method: .get) { (result: Result<[RepositoryModel], Error>) in
            switch result {
            case .success(let response):
                print(response.first?.name)
            case .failure(let error):
                print(error)
            }
        }
    }
    


}
