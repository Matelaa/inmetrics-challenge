//
//  User.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let userImage: String
    let userURL: String
    let userRepos: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case userImage = "avatar_url"
        case userURL = "url"
        case userRepos = "repos_url"
    }
}
