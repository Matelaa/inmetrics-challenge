//
//  User.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 31/05/23.
//

import Foundation

struct APIResponse: Codable {
    let items: [User]
}

struct User: Codable {
    let login: String
    let id: Int
    let userImage: String
    let userURL: String
    let userRepos: String
    let bio: String?
    let repositories: Int?
    let followers: Int?
    let following: Int?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case userImage = "avatar_url"
        case userURL = "url"
        case userRepos = "repos_url"
        case bio
        case repositories = "public_repos"
        case followers
        case following
    }
}
