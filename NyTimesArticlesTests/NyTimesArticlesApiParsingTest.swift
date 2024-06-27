//
//  NyTimesArticlesTests.swift
//  NyTimesArticlesTests
//
//  Created by Adil Anwer on 25/06/2024.
//

import XCTest
@testable import NyTimesArticles

final class NyTimesArticlesApiParsingTest: XCTestCase {
    
    var apiClient = APIClient()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    func testApiSuccess(){
        let expectation = self.expectation(description: "Fetch data")
        apiClient.send(apiRequest: ArticlesRequest()) { result in
            DispatchQueue.main.async{
                switch result {
                case .success(let response):
                    if let response = try? response.decode(to: NyArticle.self) {
                        if let results = response.body.results {
                            XCTAssertTrue(results.count > 0)
                        }
                    } else {
                        XCTFail()
                    }
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testApiParsingSuccess(){
        let expectation = self.expectation(description: "Fetch data")
        apiClient.sendRequestMock(apiRequest:ArticlesRequest()) { result in
            DispatchQueue.main.async{
                switch result {
                case .success(let response):
                    if let response = try? response.decode(to: NyArticle.self) {
                        if let results = response.body.results {
                            XCTAssertTrue(results.count > 0)
                        }
                    } else {
                        XCTFail()
                    }
                case .failure:
                    XCTFail()
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    
}
