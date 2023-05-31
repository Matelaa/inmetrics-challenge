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
        self.service.fetchUsers { users in
            self.users.append(users.first!)
            self.delegate.getUsersList()
        }
    }
}
