//
//  GitRepoTests.swift
//  GitRepoTests
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import XCTest
@testable import GitRepo

class GitRepoTests: XCTestCase {

    /// Access ReposAPI class to make HTTP repos requests
    var api:ReposAPIProtocol!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        api = ReposAPI()
    }

    override func tearDownWithError() throws {
        api = nil
        try super.tearDownWithError()
    }


    //MARK:- Test NetworkLayer Executes Success Request
    func testNetworkLayerExecuteSuccessRequest() {
        var repos: [RepositoryModel]?
        
        let expectation = expectation(description: "GET https://api.github.com/repositories")

        api.list { (result: Result<[RepositoryModel], ErrorResponse>) in
            switch result {
            case .success(let response):
                repos = response
                XCTAssert(repos?.count ?? 0 > 0)
                expectation.fulfill()
            case .failure(_):break
            }
        }

        
        waitForExpectations(timeout: 5){ error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
