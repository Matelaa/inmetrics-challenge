//
//  UserListViewController.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 30/05/23.
//

import UIKit

class UserListViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = self.view.center
        activityIndicator.color = .gray
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var typingTimer: Timer?
    
    var filteredText: String = ""
    
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        
        self.view.backgroundColor = .white
        
        self.viewModel.delegate = self
        
        self.setupUI()
        
        self.viewModel.getUsers()
    }
    
    private func setupLoadingScreen() {
        self.view.addSubview(self.activityIndicator)
        self.setupActivityIndicatorConstraints()
    }
    
    private func removeLoadingScreen() {
        self.activityIndicator.removeFromSuperview()
    }
    
    private func setupUI() {
        self.view.addSubview(self.tableView)
        
        self.setupConstraints()
        
        self.setupSearchController()
        self.setupTableView()
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.barStyle = .default
        searchController.searchBar.searchTextField.leftView?.tintColor = .black
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search users", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = .none
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupConstraints() {
        self.setupTableViewConstraints()
    }
    
    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            self.activityIndicator.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.activityIndicator.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.activityIndicator.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.activityIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.tableView.backgroundColor = .white
    }
    
    private func filterUserForSeachText(user: String) {
        self.viewModel.searchUser(searchText: user)
    }
    
    private func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension UserListViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.viewModel.resetSearch()
        self.tableView.reloadData()
        return true
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.resetSearch()
        self.reloadTableView()
    }
}

extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.typingTimer?.invalidate()
        self.typingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            let searchBar = searchController.searchBar
            self.filteredText = searchBar.text!
            self.viewModel.resetSearch()
            self.viewModel.searchUser(searchText: self.filteredText)
        })
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.isFiltering ? self.viewModel.filteredUsers.count : self.viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserListTableViewCell
        
        if self.viewModel.isFiltering {
            cell.bind(user: self.viewModel.filteredUsers[indexPath.item])
        } else {
            cell.bind(user: self.viewModel.users[indexPath.item])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryController = RepositoryViewController()
        if self.viewModel.isFiltering {
            repositoryController.viewModel.user = self.viewModel.filteredUsers[indexPath.item]
        } else {
            repositoryController.viewModel.user = self.viewModel.users[indexPath.item]
        }
        self.navigationController?.pushViewController(repositoryController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if self.viewModel.isFiltering {
            if indexPath.row == lastRowIndex && self.viewModel.filteredUsers.count % 30 == 0 {
                self.viewModel.searchUser(searchText: self.filteredText)
            }
        } else {
            if indexPath.row == lastRowIndex && self.viewModel.users.count % 30 == 0 {
                self.viewModel.getUsers()
            }
        }
    }
}

extension UserListViewController: UserViewModelDelegate {
    func hasItemFiltered(hasItem: Bool) {
        if !hasItem {
            self.createAlert(title: "Error", message: "There is no user with that name")
        }
    }
    
    
    func onIsLoadChange() {
        if self.viewModel.isLoading {
            self.setupLoadingScreen()
        } else {
            self.removeLoadingScreen()
            self.reloadTableView()
        }
    }
}
