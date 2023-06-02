//
//  UserModelTests.swift
//  inmetrics-challengeTests
//
//  Created by José Matela Neto on 02/06/23.
//

import XCTest
@testable import inmetrics_challenge

final class UserModelTests: XCTestCase {
    
    func testUserDecoding() throws {
        let json = """
            {
                "login": "Matelaa",
                "id": 37427070,
                "avatar_url": "https://avatars.githubusercontent.com/u/37427070?v=4",
                "url": "https://api.github.com/users/Matelaa",
                "repos_url": "https://api.github.com/users/Matelaa/repos",
                "bio": "iOS Developer & Computer Science Student.",
                "public_repos": 17,
                "followers": 46,
                "following": 33
            }
            """
        
        let jsonData = Data(json.utf8)
        let user = try JSONDecoder().decode(User.self, from: jsonData)
        
        XCTAssertEqual(user.login, "Matelaa")
        XCTAssertEqual(user.id, 37427070)
        XCTAssertEqual(user.userImage, "https://avatars.githubusercontent.com/u/37427070?v=4")
        XCTAssertEqual(user.userURL, "https://api.github.com/users/Matelaa")
        XCTAssertEqual(user.userRepos, "https://api.github.com/users/Matelaa/repos")
        XCTAssertEqual(user.bio, "iOS Developer & Computer Science Student.")
        XCTAssertEqual(user.repositories, 17)
        XCTAssertEqual(user.followers, 46)
        XCTAssertEqual(user.following, 33)
    }
}
