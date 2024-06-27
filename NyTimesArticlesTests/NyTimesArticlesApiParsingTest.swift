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
    
    func testApiParsingSuccess(){
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
            }
        }
    }
    
}
