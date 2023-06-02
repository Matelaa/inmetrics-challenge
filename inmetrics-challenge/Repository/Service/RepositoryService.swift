//
//  RepositoryService.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 01/06/23.
//

import Foundation

class RepositoryService {
    
    func fetchUserInfo(baseURL: String, completion: @escaping (User) -> ()) {
        let url = URL(string: baseURL)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                let user = try? JSONDecoder().decode(User.self, from: data)
                //MARK: DISCLAIMER - Esse metodo so esta aqui para poder de fato mostrar o loading funcionando
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completion(user!)
                }
            }
        }
        task.resume()
    }
    
    
    func fetchRepositories(name: String, page: Int, completion: @escaping ([Repository]) -> ()) {
        let baseURL: String = "https://api.github.com/users/\(name)/repos?page=\(page)&per_page=30"
        let url = URL(string: baseURL)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                let repositories = try? JSONDecoder().decode([Repository].self, from: data)
                //MARK: DISCLAIMER - Esse metodo so esta aqui para poder de fato mostrar o loading funcionando
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completion(repositories!)
                }
            }
        }
        task.resume()
    }
}
