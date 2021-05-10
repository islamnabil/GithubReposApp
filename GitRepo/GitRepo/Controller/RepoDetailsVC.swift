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
    
    //MARK:- IBOutlets
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    //MARK:- Private methods
    private func setData(){
        ownerImage.getImage(from: repo?.owner?.avatarUrl ?? "", id: repo?.owner?.id ?? Int())
        ownerNameLabel.text = repo?.owner?.login ?? ""
        repoTitleLabel.text = repo?.name ?? ""
        repoDescriptionLabel.text = repo?.description ?? ""
    }
    
    //MARK:- Public methods
    public func configureView(repo:RepositoryModel){
        self.repo = repo
    }
    
    
}
