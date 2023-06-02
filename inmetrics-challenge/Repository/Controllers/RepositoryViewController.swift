//
//  RepositoryViewController.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 01/06/23.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = self.view.center
        activityIndicator.color = .gray
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(red: 0.55, green: 0.56, blue: 0.61, alpha: 1.00)
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var followersImageView: UIImageView = {
        let image = UIImage(named: "followers_icon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var followingImageView: UIImageView = {
        let image = UIImage(named: "following_icon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var repositoriesImageView: UIImageView = {
        let image = UIImage(named: "repositories_icon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var repositoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = RepositoryViewModel()
    var updatedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModel.user.login
        self.viewModel.delegate = self
        
        self.viewModel.getDetailsUser(url: self.viewModel.user.userURL)
    }
    
    private func setupLoadingScreen() {
        self.view.addSubview(self.activityIndicator)
        self.setupActivityIndicatorConstraints()
    }
    
    private func removeLoadingScreen() {
        self.activityIndicator.removeFromSuperview()
    }
    
    private func setupUI() {
        self.view.addSubview(self.contentView)
        
        self.contentView.addSubview(self.userImageView)
        self.contentView.addSubview(self.userNameLabel)
        self.contentView.addSubview(self.bioLabel)
        self.contentView.addSubview(self.followersImageView)
        self.contentView.addSubview(self.followersLabel)
        self.contentView.addSubview(self.followingImageView)
        self.contentView.addSubview(self.followingLabel)
        self.contentView.addSubview(self.repositoriesImageView)
        self.contentView.addSubview(self.repositoriesLabel)

        self.view.addSubview(self.tableView)
        
        self.setupConstraints()
        
        self.setupCornerRadiusInView()
        self.setupShadows()
        
        self.setupTableView()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func bind(user: User) {
        let urlAvatarImage = self.viewModel.setupImageOfUserInCell(userAvatarUrl: user.userImage)
        self.userImageView.kf.setImage(with: urlAvatarImage)
        self.userNameLabel.text = user.login
        self.bioLabel.text = user.bio
        self.followersLabel.text = String(user.followers!)
        self.followingLabel.text = String(user.following!)
        self.repositoriesLabel.text = String(user.repositories!)
    }
    
    private func setupConstraints() {
        self.setupContentViewConstraints()
        self.setupUserImageViewConstraints()
        self.setupUserNameLabelConstraints()
        self.setupBioLabelConstraints()
        self.setupTableViewConstraints()
        self.setupFollowersIconImageViewConstraints()
        self.setupFollowersNumbersLabelConstraints()
        self.setupFollowingIconImageViewConstraints()
        self.setupFollowingNumbersLabelConstraints()
        self.setupRepositoriesIconImageViewConstraints()
        self.setupRepositoriesNumbersLabelConstraints()
    }
    
    private func setupCornerRadiusInView() {
        self.view.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    private func setupShadows() {
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.4
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowRadius = 1
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = .none
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 200),
            self.contentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            self.contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12),
            self.contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12)
        ])
        self.contentView.backgroundColor = .white
    }
    
    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            self.activityIndicator.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.activityIndicator.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.activityIndicator.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.activityIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func setupUserImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.userImageView.heightAnchor.constraint(equalToConstant: 100),
            self.userImageView.widthAnchor.constraint(equalToConstant: 100),
            self.userImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.userImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12)
        ])
        
        self.view.layoutIfNeeded()
        self.userImageView.layer.masksToBounds = true
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
    }
    
    private func setupUserNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.userNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.userNameLabel.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 12),
            self.userNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 8)
        ])
    }
    
    private func setupBioLabelConstraints() {
        NSLayoutConstraint.activate([
            self.bioLabel.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 8),
            self.bioLabel.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 12),
            self.bioLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 8)
        ])
    }
    
    private func setupFollowersIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.followersImageView.heightAnchor.constraint(equalToConstant: 16),
            self.followersImageView.widthAnchor.constraint(equalToConstant: 16),
            self.followersImageView.topAnchor.constraint(equalTo: self.bioLabel.bottomAnchor, constant: 8),
            self.followersImageView.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 12)
        ])
        self.followersImageView.tintColor = .black
    }
    
    private func setupFollowersNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            self.followersLabel.centerYAnchor.constraint(equalTo: self.followersImageView.centerYAnchor),
            self.followersLabel.leftAnchor.constraint(equalTo: self.followersImageView.rightAnchor, constant: 4)
        ])
    }
    
    private func setupFollowingIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.followingImageView.heightAnchor.constraint(equalToConstant: 16),
            self.followingImageView.widthAnchor.constraint(equalToConstant: 16),
            self.followingImageView.topAnchor.constraint(equalTo: self.followersImageView.bottomAnchor, constant: 8),
            self.followingImageView.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 12)
        ])
        self.followingImageView.tintColor = .black
    }
    
    private func setupFollowingNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            self.followingLabel.centerYAnchor.constraint(equalTo: self.followingImageView.centerYAnchor),
            self.followingLabel.leftAnchor.constraint(equalTo: self.followingImageView.rightAnchor, constant: 4)
        ])
    }
    
    private func setupRepositoriesIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.repositoriesImageView.heightAnchor.constraint(equalToConstant: 16),
            self.repositoriesImageView.widthAnchor.constraint(equalToConstant: 16),
            self.repositoriesImageView.topAnchor.constraint(equalTo: self.followingImageView.bottomAnchor, constant: 8),
            self.repositoriesImageView.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 12)
        ])
        self.repositoriesImageView.tintColor = .black
    }

    private func setupRepositoriesNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            self.repositoriesLabel.centerYAnchor.constraint(equalTo: self.repositoriesImageView.centerYAnchor),
            self.repositoriesLabel.leftAnchor.constraint(equalTo: self.repositoriesImageView.rightAnchor, constant: 4)
        ])
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 12),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.tableView.backgroundColor = .white
    }
}

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RepositoryTableViewCell
        
        cell.bind(repository: self.viewModel.repositories[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && self.viewModel.repositories.count % 30 == 0 {
            self.viewModel.getRepositories(name: self.viewModel.user.login)
        }
    }
}

extension RepositoryViewController: UserViewModelDelegate {
    func hasItemFiltered(hasItem: Bool) {}
    
    func onIsLoadChange() {
        if self.viewModel.isLoading {
            self.setupLoadingScreen()
        } else {
            self.removeLoadingScreen()
            
            self.bind(user: self.viewModel.user)
            
            self.setupUI()
            self.reloadTableView()
        }
    }
}
