//
//  RepositoryTableViewCell.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 01/06/23.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameRepositoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(red: 0.55, green: 0.56, blue: 0.61, alpha: 1.00)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    lazy var starIconImageView: UIImageView = {
        let image = UIImage(named: "star_icon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var starNumbersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var languageIconImageView: UIImageView = {
        let image = UIImage(named: "language_icon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    var repository: Repository!
    var repositoryViewModel = RepositoryViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(repository: Repository) {
        self.repository = repository
        self.nameRepositoryLabel.text = self.repository.name
        self.descriptionLabel.text = self.repository.description
        self.starNumbersLabel.text = String(self.repository.stars)
        self.languageLabel.text = self.repositoryViewModel.checkLanguagueIsEmpty(repository: self.repository)
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
        
        self.containerView.addSubview(self.nameRepositoryLabel)
        self.containerView.addSubview(self.descriptionLabel)
        self.containerView.addSubview(self.starIconImageView)
        self.containerView.addSubview(self.starNumbersLabel)
        self.containerView.addSubview(self.languageIconImageView)
        self.containerView.addSubview(self.languageLabel)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupContainerViewConstraints()
        self.setupUserNameLabelConstraints()
        self.setupDescriptionLabelConstraints()
        self.setupStarIconImageViewConstraints()
        self.setupStarNumbersLabelConstraints()
        self.setupLanguageImageViewConstraints()
        self.setupLanguageLabelConstraints()
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
    
    private func setupUserNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.nameRepositoryLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 12),
            self.nameRepositoryLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 12),
            self.nameRepositoryLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.nameRepositoryLabel.bottomAnchor, constant: 8),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 12),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -4)
        ])
    }
    
    private func setupStarIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.starIconImageView.heightAnchor.constraint(equalToConstant: 16),
            self.starIconImageView.widthAnchor.constraint(equalToConstant: 16),
            self.starIconImageView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 8),
            self.starIconImageView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 12)
        ])
        self.starIconImageView.tintColor = .black
    }
    
    private func setupStarNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            self.starNumbersLabel.centerYAnchor.constraint(equalTo: self.starIconImageView.centerYAnchor),
            self.starNumbersLabel.leftAnchor.constraint(equalTo: self.starIconImageView.rightAnchor, constant: 4)
        ])
    }
    
    private func setupLanguageImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.languageIconImageView.heightAnchor.constraint(equalToConstant: 16),
            self.languageIconImageView.widthAnchor.constraint(equalToConstant: 16),
            self.languageIconImageView.centerYAnchor.constraint(equalTo: self.starNumbersLabel.centerYAnchor),
            self.languageIconImageView.leftAnchor.constraint(equalTo: self.starNumbersLabel.rightAnchor, constant: 4)
        ])
        self.languageIconImageView.tintColor = .black
    }
    
    private func setupLanguageLabelConstraints() {
        NSLayoutConstraint.activate([
            self.languageLabel.centerYAnchor.constraint(equalTo: self.languageIconImageView.centerYAnchor),
            self.languageLabel.leftAnchor.constraint(equalTo: self.languageIconImageView.rightAnchor, constant: 4)
        ])
    }
}
