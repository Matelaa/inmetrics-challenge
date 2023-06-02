//
//  UserViewModel.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import Foundation

protocol UserViewModelDelegate: AnyObject {
    func onIsLoadChange()
    func hasItemFiltered(hasItem: Bool)
}

class UserViewModel {
    
    weak var delegate: UserViewModelDelegate?
    let service = UserService()
    var users = [User]()
    var isLoading: Bool = false
    var isFiltering: Bool = false
    var since: Int = 0
    var pageFilteredUsers: Int = 0
    var filteredUsers = [User]()
    var noUserFound: Bool = false
    
    func getUsers() {
        self.isLoading = true
        self.delegate?.onIsLoadChange()
        self.service.fetchUsers(since: self.since) { [weak self] lastId, user  in
            self?.since = lastId
            self?.users.append(contentsOf: user)
            self?.isLoading = false
            self?.delegate?.onIsLoadChange()
        }
    }
    
    func searchUser(searchText: String) {
        if searchText.isEmpty {
            self.filteredUsers = []
            return
        }
        self.pageFilteredUsers += 1
        self.isLoading = true
        self.isFiltering = true
        self.noUserFound = false
        self.delegate?.onIsLoadChange()
        self.service.searchUsers(page: self.pageFilteredUsers, user: searchText) { [weak self] user in
            if user.isEmpty {
                self?.isLoading = false
                self?.noUserFound = true
                self?.delegate?.hasItemFiltered(hasItem: !self!.noUserFound)
                self?.delegate?.onIsLoadChange()
            } else {
                self?.isLoading = false
                self?.filteredUsers.append(contentsOf: user)
                self?.delegate?.onIsLoadChange()
            }
        }
    }
    
    func resetSearch() {
        self.pageFilteredUsers = 0
        self.isFiltering = false
        self.filteredUsers = []
    }
    
    func setupImageOfUserInCell(userAvatarUrl: String) -> URL? {
        let url = URL(string: userAvatarUrl)
        return url
    }
}
