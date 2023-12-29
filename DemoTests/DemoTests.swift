//
//  DemoTests.swift
//  DemoTests
//
//  Created by Seher Aytekin on 12/28/23.
//

import XCTest
@testable import Demo

final class DemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let viewModel = SearchViewModel(SearchDependencyResolver(MockSearchManager(.success)))
            
            viewModel.search(for: "Rent")
        }
    }
    
    func testSearchViewModel_Success() {
        
        let viewModel = SearchViewModel(SearchDependencyResolver(MockSearchManager(.success)))
        
        viewModel.search(for: "Rent")
        
        XCTAssert(viewModel.dataSource.count == 5)
        XCTAssertEqual(viewModel.dataSource[0].id, "1")
        
    }
    
    func testSearchViewModel_Failure() {
        
        let viewModel = SearchViewModel(SearchDependencyResolver(MockSearchManager(.failure)))
        
        viewModel.search(for: "Rent")
        
        XCTAssert(viewModel.dataSource.count == 0)
        
        
    }

}

