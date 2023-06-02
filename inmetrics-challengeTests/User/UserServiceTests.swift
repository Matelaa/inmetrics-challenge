//
//  inmetrics_challengeTests.swift
//  inmetrics-challengeTests
//
//  Created by José Matela Neto on 30/05/23.
//

import XCTest
@testable import inmetrics_challenge

final class inmetrics_challengeTests: XCTestCase {
    var userService: UserService!
    
    override func setUp() {
        super.setUp()
        userService = UserService()
    }
    
    override func tearDown() {
        userService = nil
        super.tearDown()
    }
    
    func testFetchUsers() {
        let expectation = XCTestExpectation(description: "Search Users")
        
        userService.fetchUsers(since: 0) { lastId, users in
            
            XCTAssertGreaterThan(users.count, 29)
            XCTAssertLessThan(users.count, 31)
            XCTAssertNotNil(users.first)
            XCTAssertEqual(users.last?.id, lastId)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchUsers() {
        let expectation = XCTestExpectation(description: "Search Users")
        
        userService.searchUsers(page: 1, user: "Matelaa") { users in
            
            XCTAssertGreaterThan(users.count, 0)
            XCTAssertNotNil(users.first)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
