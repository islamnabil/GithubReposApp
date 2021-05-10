//
//  RepoDetailsVC.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import UIKit

class RepoDetailsVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK:- Public methods
    public func configureView(repo:RepositoryModel){
        
    }
    
    
}
