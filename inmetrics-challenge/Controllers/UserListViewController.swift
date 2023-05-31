//
//  ViewController.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 30/05/23.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        self.setupUI()
        
        self.viewModel.getUsers()
    }
    
    private func setupUI() {
        self.view.addSubview(self.tableView)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        self.tableView.backgroundColor = .green
    }
}

