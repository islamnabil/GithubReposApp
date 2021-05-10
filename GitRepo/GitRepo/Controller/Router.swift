//
//  Router.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import UIKit

enum Storyboards:String {
    case Main = "Main"
}

enum VCs:String {
    case ReposListVC = "ReposListVC"
    case RepoDetailsVC = "RepoDetailsVC"
}

protocol StoryboardViewController {
    var storyboard:String {get}
}

extension VCs: StoryboardViewController {
    var storyboard: String {
        switch self {
        case .ReposListVC, .RepoDetailsVC:
            return Storyboards.Main.rawValue
        }
    }
}


extension UIViewController {
    func presentRepoDetails(for repo:RepositoryModel) {
        let vc = UIStoryboard(name: VCs.RepoDetailsVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: VCs.RepoDetailsVC.rawValue) as! RepoDetailsVC
        vc.configureView(repo: repo)
        present(vc, animated: true, completion: nil)
    }
}
