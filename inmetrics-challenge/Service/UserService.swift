//
//  UserService.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import Foundation

class UserService {
    
    func fetchUsers(since: Int, completion: @escaping (Int, [User]) -> ()) {
        let baseURL: String = "https://api.github.com/users?since=\(since)&per_page=30"
        let url = URL(string: baseURL)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            //MARK: TODO - trabalhar com as responses (httpcode), e caso tenha erro para tratar
            print("RESPONSE: \(String(describing: response))")
            print("ERROR: \(String(describing: error?.localizedDescription))")
            
            if let data = data {
                let users = try? JSONDecoder().decode([User].self, from: data)
                if let lastId = users?.last?.id {
                    //MARK: DISCLAIMER - Esse metodo so esta aqui para poder de fato mostrar o loading funcionando
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        completion(lastId, users!)
                    }
                }
            }
        }
        task.resume()
    }
}
