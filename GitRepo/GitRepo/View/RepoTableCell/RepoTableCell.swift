//
//  RepoTableCell.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import UIKit

class RepoTableCell: UITableViewCell {
    
    // MARK:- IBoutlets
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    
    // MARK:- Configure View
    func configureView(repo:RepositoryModel) {
        let owner = repo.owner
        ownerImage.getImage(from: owner?.avatarUrl ?? "", id: owner?.id ?? Int())
        ownerNameLabel.text = owner?.login
        repoNameLabel.text =  repo.name
        // TODO:- creationDateLabel
    }

    
}
