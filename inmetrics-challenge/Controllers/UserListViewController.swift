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
    
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.setupTableView()
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
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserListTableViewCell
        
        cell.bind(user: self.viewModel.users[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.viewModel.users[indexPath.item].login)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            self.viewModel.getUsers()
        }
    }
}

extension UserListViewController: UserViewModelDelegate {
    
    func onIsLoadChange() {
        if self.viewModel.isLoading {
            self.setupLoadingScreen()
        } else {
            self.removeLoadingScreen()
            self.reloadTableView()
        }
    }
}
