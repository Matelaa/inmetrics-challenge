//
//  UserViewModel.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import Foundation

protocol UserViewModelDelegate: AnyObject {
    func onIsLoadChange()
}

class UserViewModel {
    
    weak var delegate: UserViewModelDelegate?
    let service = UserService()
    var users = [User]()
    var isLoading: Bool = false
    var since: Int = 0
    
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
    
    func setupImageOfUserInCell(userAvatarUrl: String) -> URL? {
        let url = URL(string: userAvatarUrl)
        return url
    }
}
