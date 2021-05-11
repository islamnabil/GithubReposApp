//
//  ReposListVC.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import UIKit

class ReposListVC: UIViewController {
    //MARK:- Properties
    
    /// Access the singleton instance
    let spinner = PrivateSwiftSpinner.shared
    
    /// Access ReposAPI class to make HTTP repos requests
    let api:ReposAPIProtocol = ReposAPI()
    
    /// The repos array to display at `reposTable` when `searchActive = false`
    var repos: [RepositoryModel]?
    
    /// The repos array to display at `reposTable` when `searchActive = true`
    var searchResults: [RepositoryModel]?
    
    /// `searchActive = true` when `beginEditing` at `searchBar` and `searchBar.text?.count ?? 0 >= 2`,
    ///  then display ONLY filtered results at `reposTable`
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
    
    /// configureReposTable : `delegate`, `dataSource`
    /// and make `separatorStyle` to be none instead of singleLine
    private func configureReposTable() {
        reposTable.register(UINib(nibName: "RepoTableCell", bundle: nil), forCellReuseIdentifier: "RepoTableCell")
        reposTable.delegate = self
        reposTable.dataSource = self
        reposTable.separatorStyle = .none
    }
    
    /// Set data after call HTTP request & reload `reposTable`
    /// - Parameters:
    ///   - repos: Repos array to be display at `reposTable`
    private func setData(repos:[RepositoryModel]){
        self.repos = repos
        reposTable.reloadData()
    }
    
    private func configureSearchBar(){
        searchBar.delegate = self
    }
    
    /// get Repo object data
    /// if `searchActive` true it returns object from search results
    /// if `searchActive` false it returns object from fetched repos from HTTP
    /// - Parameters:
    ///   - indexPath: indexPath of current tableView cell
    /// - Returns: Repo object to the current tableView cell
    private func getRepo(cellForRowAt indexPath: IndexPath) -> RepositoryModel {
        return searchActive ? (searchResults?[indexPath.row] ?? RepositoryModel()) : (repos?[indexPath.row] ?? RepositoryModel())
    }
    
}


// MARK: - UITableView Delegate
extension ReposListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// if `searchActive` is true it returns `searchResults` count
        /// if `searchActive` is false it returns `repos` count
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
       /// present Repo Details of current selected repo
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
    
    
    /// When end editing at `searchBar`:
    /// make `searchBar`empty,
    /// `searchActive = false` to reload `RepoTable` with `repos` array instead of `searchResults` array,
    /// force view to endEditing to dismiss keyboard from Screen
    private func endEditing(){
        searchBar.text?.removeAll()
        searchActive = false
        view.endEditing(true)
    }
    
    
    /// When begin editing at `searchBar`:
    /// check if `text` in `searchBar` string count > or = 2, then
    /// set `searchResults` with filtered data from `repos` which contains a substring text of `searchBar`,
    /// then make `searchActive = true` to reload `RepoTable` with `searchResults` array instead of `repos` array
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
    
    /// getReposAPI
    /// if `success`, then `setData` with fetched repos and hide `spinner`.
    /// if `failure`, pring `error` at console.
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


