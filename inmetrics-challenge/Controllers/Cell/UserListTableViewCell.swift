//
//  UserListTableViewCell.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import UIKit
import Kingfisher

class UserListTableViewCell: UITableViewCell {
    
    lazy var userImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var userNameLabem: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var user: User!
    
    /* MARK: - TODO: 1. Setar o nome
       MARK: - TODO: 2. Estilizar celula
       MARK: - TODO: 3. Mudar para ViewModel a setagem de URL
    */
    func bind(user: User) {
        self.user = user
        let url = URL(string: self.user.userImage)
        self.userImageView.kf.setImage(with: url)
    }
    
    private func setupUI() {
        self.addSubview(self.userImageView)
//        self.addSubview(self.userNameLabel)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupUserImageView()
        self.setupUserNameLabel()
    }
    
    private func setupUserImageView() {
        NSLayoutConstraint.activate([
            self.userImageView.heightAnchor.constraint(equalToConstant: 20),
            self.userImageView.widthAnchor.constraint(equalToConstant: 20),
            self.userImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupUserNameLabel() {
        
    }
}
