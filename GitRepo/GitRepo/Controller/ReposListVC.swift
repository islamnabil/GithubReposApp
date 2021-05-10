//
//  ReposListVC.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import UIKit

class ReposListVC: UIViewController {
    //MARK:- Properties
    let spinner = PrivateSwiftSpinner.shared
    let api:ReposAPIProtocol = ReposAPI()
    var repos: [RepositoryModel]?
    var searchResults: [RepositoryModel]?
    var searchActive = false {
        didSet {
            reposTable.reloadData()
        }
    }
    
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
    
    private func getRepo(cellForRowAt indexPath: IndexPath) -> RepositoryModel {
        return searchActive ? (searchResults?[indexPath.row] ?? RepositoryModel()) : (repos?[indexPath.row] ?? RepositoryModel())
    }
    
}


// MARK: - UITableView Delegate
extension ReposListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? searchResults?.count ?? 0 : repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableCell.self),for: indexPath) as! RepoTableCell
        cell.configureView(repo: getRepo(cellForRowAt: indexPath))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       presentRepoDetails(for: getRepo(cellForRowAt: indexPath))
    }
    
}

// MARK: - UISearchBar Delegate
extension ReposListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        beginEditing()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
    
    private func endEditing(){
        searchBar.text?.removeAll()
        searchActive = false
        view.endEditing(true)
    }
    
    private func beginEditing(){
        if searchBar.text?.count ?? 0 >= 2 {
            searchResults = repos?.filter({ (repo) -> Bool in
                return repo.name?.lowercased().contains(searchBar.text?.lowercased() ?? "") ?? false
            })
            searchActive = true
        }else {
            searchActive = false
        }
    }
    
}

// MARK: - APIs
extension ReposListVC {
    private func getReposAPI(){
        spinner.show()
        api.list { (result: Result<[RepositoryModel], NSError>) in
            switch result {
            case .success(let response):
                self.setData(repos: response)
                self.spinner.hide()
            case .failure(let error):
                print(error)
            }
        }
    }
}

class OmnerImagesCache {
    private init(){}
    static var shared = OmnerImagesCache()
    var images = [Int:UIImage]()
}
