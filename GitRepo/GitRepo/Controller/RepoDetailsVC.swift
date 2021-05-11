//
//  RepoDetailsVC.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import UIKit

class RepoDetailsVC: UIViewController {

    //MARK:- Properties
    private var repo:RepositoryModel?
    private var fullName:String?
    
    /// Access ReposAPI class to make HTTP repos requests
    private let api:ReposAPIProtocol = ReposAPI()
    
    //MARK:- IBOutlets
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepoDetailsAPI(fullname: fullName ?? "")
    }
    
    //MARK:- Private methods
    private func setData(){
        
        /// get owner image from `getImage` HTTP function
        ownerImage.getImage(from: repo?.owner?.avatarUrl ?? "", id: repo?.owner?.id ?? Int())
        
        ownerNameLabel.text = repo?.owner?.login ?? ""
        repoTitleLabel.text = repo?.name ?? ""
        repoDescriptionLabel.text = repo?.description ?? ""
    }
    
    //MARK:- Public methods
    
    /// configure RepoDetailsVC to pass data to `RepoDetailsVC` from another `ViewController`
    /// 
    /// - Parameters:
    ///   - fullName: repo object to be displayed
    public func configureView(fullName:String){
        self.fullName = fullName
    }
    
    /// Set data after call HTTP request
    ///
    /// - Parameters:
    ///   - repo: Repo to be displayed
    private func setData(repo:RepositoryModel){
        self.repo = repo
        setData()
    }
    
    
}

// MARK: - APIs
extension RepoDetailsVC {
    
    /// getRepoDetailsAPI
    /// if `success`, then `setData` with fetched repo.
    private func getRepoDetailsAPI(fullname:String){
        api.details(fullname:fullname) { (result: Result<RepositoryModel, ErrorResponse>) in
            switch result {
            case .success(let response):
                self.setData(repo: response)
            case .failure(_):break
            }
        }
    }
}
