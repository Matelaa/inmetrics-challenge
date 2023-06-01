//
//  UserViewModel.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import Foundation

protocol UserViewModelDelegate {
    func getUsersList()
}

class UserViewModel {
    
    var delegate: UserViewModelDelegate!
    let service = UserService()
    var users = [User]()
    
    func getUsers() {
        self.service.fetchUsers { user in
            self.users.append(contentsOf: user)
            self.delegate.getUsersList()
        }
    }
    
    func setupImageOfUserInCell(userAvatarUrl: String) -> URL? {
        let url = URL(string: userAvatarUrl)
        return url
    }
}
