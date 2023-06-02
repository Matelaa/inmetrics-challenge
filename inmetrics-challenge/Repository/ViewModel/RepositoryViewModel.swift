//
//  RepositoryViewModel.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 01/06/23.
//

import Foundation

class RepositoryViewModel {
    
    weak var delegate: UserViewModelDelegate?
    let service = RepositoryService()
    var repositories = [Repository]()
    var user: User!
    var isLoading: Bool = false
    var name: String = ""
    var numberOfFollowers: Int = 0
    var pageRepositories: Int = 0
    
    
    func getDetailsUser(url: String) {
        self.pageRepositories += 1
        self.isLoading = true
        self.delegate?.onIsLoadChange()
        self.service.fetchUserInfo(baseURL: url) { user in
            self.user = user
            self.service.fetchRepositories(name: self.user.login, page: self.pageRepositories) { repository in
                self.isLoading = false
                self.repositories.append(contentsOf: repository)
                self.delegate?.onIsLoadChange()
            }
        }
    }
    
    func getRepositories(name: String) {
        self.pageRepositories += 1
        self.isLoading = true
        self.delegate?.onIsLoadChange()
        self.service.fetchRepositories(name: name, page: self.pageRepositories) { [weak self] repository in
            self?.isLoading = false
            self?.repositories.append(contentsOf: repository)
            self?.delegate?.onIsLoadChange()
        }
    }
    
    func checkRepositoriesIsEmpty(repositories: [Repository]) -> Bool {
        return repositories.count == 0 ? true : false
    }
    
    func checkLanguagueIsEmpty(repository: Repository) -> String {
        return repository.language == nil ? "No language provided" : repository.language!
    }
    
    func setupImageOfUserInCell(userAvatarUrl: String) -> URL? {
        let url = URL(string: userAvatarUrl)
        return url
    }
}
