//
//  ReposListVC.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import UIKit

class ReposListVC: UIViewController {
    //MARK:- Properties
    var repos: [RepositoryModel]?
    
    // MARK:- IBoutlets
    @IBOutlet weak var reposTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureReposTable()
        configureSearchBar()
        getReposAPI()
    }
    
    //MARK:- Private Methods
    private func configureReposTable() {
        reposTable.register(UINib(nibName: "RepoTableCell", bundle: nil), forCellReuseIdentifier: "RepoTableCell")
        reposTable.delegate = self
        reposTable.dataSource = self
        reposTable.separatorStyle = .none
    }
    
    private func setData(repos:[RepositoryModel]){
        self.repos = repos
        reposTable.reloadData()
    }
    
    private func configureSearchBar(){
        searchBar.delegate = self
    }

}


// MARK: - UITableView Delegate
extension ReposListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableCell.self),for: indexPath) as! RepoTableCell
        cell.configureView(repo: repos?[indexPath.row] ?? RepositoryModel())
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}

// MARK: - UISearchBar Delegate
extension ReposListVC: UISearchBarDelegate {
    
    
}

// MARK: - APIs
extension ReposListVC {
    private func getReposAPI(){
        NetworkEngine.request(url: URL(string: "https://api.github.com/repositories")!, method: .get) { (result: Result<[RepositoryModel], Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async() { [weak self] in
                    self?.setData(repos: response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


