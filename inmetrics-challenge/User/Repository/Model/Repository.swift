//
//  Repository.swift
//  inmetrics-challenge
//
//  Created by José Matela Neto on 01/06/23.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let owner: User
    let description: String?
    let stars: Int
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case description
        case stars = "stargazers_count"
        case language = "language"
    }
}
