//
//  UserListTableViewCell.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import UIKit
import Kingfisher

class UserListTableViewCell: UITableViewCell {
    
    lazy var containerView: UIView = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var user: User!
    let viewModel = UserViewModel()
    
    func bind(user: User) {
        self.user = user
        let urlAvatarImage = self.viewModel.setupImageOfUserInCell(userAvatarUrl: self.user.userImage)
        self.userImageView.kf.setImage(with: urlAvatarImage)
        self.userNameLabel.text = self.user.login
    }
    
    private func setupCornerRadiusInCell() {
        self.clipsToBounds = true
        self.containerView.layer.cornerRadius = 10
    }
    
    private func setupShadows() {
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 0.4
        self.containerView.layer.shadowOffset = .zero
        self.containerView.layer.shadowRadius = 1
    }
    
    private func setupUI() {
        self.setupCornerRadiusInCell()
        self.setupShadows()
        
        self.addSubview(self.containerView)
        
        self.containerView.addSubview(self.userImageView)
        self.containerView.addSubview(self.userNameLabel)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupContainerViewConstraints()
        self.setupUserImageViewConstraints()
        self.setupUserNameLabelConstraints()
    }
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        self.containerView.backgroundColor = .white
    }
    
    private func setupUserImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.userImageView.heightAnchor.constraint(equalToConstant: 70),
            self.userImageView.widthAnchor.constraint(equalToConstant: 70),
            self.userImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.userImageView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 12)
        ])
        
        self.layoutIfNeeded()
        self.userImageView.layer.masksToBounds = true
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
    }
    
    private func setupUserNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.userNameLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.userNameLabel.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 12),
            self.userNameLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor)
        ])
    }
}
