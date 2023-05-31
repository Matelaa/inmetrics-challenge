//
//  UserService.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import Foundation

class UserService {
    let baseURL: String = "https://api.github.com/users"
    
    //MARK: TODO - 1. Verificar e criar paginacao para listagem de usuarios
    
    func fetchUsers(completion: @escaping ([User]) -> ()) {
        let url = URL(string: self.baseURL)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("RESPONSE: \(String(describing: response))")
            print("ERROR: \(String(describing: error?.localizedDescription))")
            
            if let data = data {
                let users = try? JSONDecoder().decode([User].self, from: data)
                completion(users!)
            }
        }
        task.resume()
    }
}
