//
//  Router.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import UIKit

/// The enum of `Storyboard(s)` at the project
enum Storyboards:String {
    case Main = "Main"
}

/// The enum of `UIViewControllers` at the project
enum VCs:String {
    case ReposListVC = "ReposListVC"
    case RepoDetailsVC = "RepoDetailsVC"
}

/// The protocol to get the `storyboard` of current `UIViewController`
protocol StoryboardViewController {
    var storyboard:String {get}
}


/// `VCs` Implements `StoryboardViewController` protocol
extension VCs: StoryboardViewController {
    var storyboard: String {
        switch self {
        case .ReposListVC, .RepoDetailsVC:
            return Storyboards.Main.rawValue
        }
    }
}

/// `UIViewController` extension to present/push ViewControllers
extension UIViewController {
    func pushRepoDetails(for fullname:String) {
        
        let vc = UIStoryboard(name: VCs.RepoDetailsVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: VCs.RepoDetailsVC.rawValue) as! RepoDetailsVC
        
        /// configure RepoDetailsVC to pass data to `RepoDetailsVC` from another `ViewController`
        vc.configureView(fullName: fullname)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
