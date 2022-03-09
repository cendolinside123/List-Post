//
//  ListPostUT.swift
//  List PostTests
//
//  Created by Jan Sebastian on 09/03/22.
//

import XCTest
@testable import List_Post

class ListPostUT: XCTestCase {
    var viewModel: ListPostVMGuideline?
    
    
    func testBasicDataLoad() {
        let useCase = UseCaseListPost(postDataSource: PostMockupDataSource(), userDataSource: UserMockupDataSource())
        viewModel = ListPostViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return list of post")
        
        viewModel!.postResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.listPost.count, 0)
            loadExpectation.fulfill()
        }
        viewModel!.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.loadListPost(try: 3)
        wait(for: [loadExpectation], timeout: 1)
    }
    
    func testDataValidation_Mockup() {
        let useCase = UseCaseListPost(postDataSource: PostMockupDataSource(), userDataSource: UserMockupDataSource())
        viewModel = ListPostViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return list of post")
        
        viewModel!.postResult = { _ in
            for item in self.viewModel!.listPost {
                XCTAssertNotNil(item.userInfo)
                XCTAssertEqual(item.userId, item.userInfo?.id)
            }
            
            
            loadExpectation.fulfill()
        }
        viewModel!.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.loadListPost(try: 3)
        wait(for: [loadExpectation], timeout: 1)
    }
    
    func testAPIRun() {
        let useCase = UseCaseListPost(postDataSource: PostDataSource(), userDataSource: UserDataSource())
        viewModel = ListPostViewModel(useCase: useCase)
        
        let loadExpectation = expectation(description: "should return list of post")
        
        viewModel!.postResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.listPost.count, 0)
            loadExpectation.fulfill()
        }
        viewModel!.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.loadListPost(try: 3)
        wait(for: [loadExpectation], timeout: 3)
    }
    
    
    func testDataValidation() {
        let useCase = UseCaseListPost(postDataSource: PostDataSource(), userDataSource: UserDataSource())
        viewModel = ListPostViewModel(useCase: useCase)
        
        let loadExpectation = expectation(description: "should return list of post")
        
        viewModel!.postResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.listPost.count, 0)
            
            for item in self.viewModel!.listPost {
                XCTAssertNotNil(item.userInfo)
                XCTAssertEqual(item.userId, item.userInfo?.id)
            }
            
            
            loadExpectation.fulfill()
        }
        viewModel!.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.loadListPost(try: 3)
        wait(for: [loadExpectation], timeout: 3)
        
        
    }
    
}
