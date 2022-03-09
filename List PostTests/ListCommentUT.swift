//
//  ListCommentUT.swift
//  List PostTests
//
//  Created by Jan Sebastian on 09/03/22.
//

import XCTest
@testable import List_Post

class ListCommentUT: XCTestCase {
    var viewModel: ListCommentVMGuideline?
    
    func testDisplayCommentOfPost_Dummy() {
        viewModel = ListCommentViewModel(useCase: CommentsMockupDataSource())
        
        let loadExpectation = expectation(description: "should return list comment of post")
        
        viewModel?.commentResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.listComment.count, 0)
            XCTAssertEqual(self.viewModel?.listComment, Constant.commentPost1)
            loadExpectation.fulfill()
        }
        viewModel!.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.loadCommentOfPost(id: 1, try: 3)
        wait(for: [loadExpectation], timeout: 1)
        
    }
    
    func testDisplayCommentOfPost_Real() {
        viewModel = ListCommentViewModel(useCase: CommentDataSource())
        
        let loadExpectation = expectation(description: "should return list comment of post")
        
        viewModel?.commentResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.listComment.count, 0)
            XCTAssertEqual(self.viewModel?.listComment, Constant.commentPost1)
            loadExpectation.fulfill()
        }
        viewModel!.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.loadCommentOfPost(id: 1, try: 3)
        wait(for: [loadExpectation], timeout: 1)
    }
}
