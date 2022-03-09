//
//  ListCommentVMGuideline.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

protocol ListCommentVMGuideline {
    func loadCommentOfPost(id postID: Int, try reloadTime: Int)
    var commentResult: (([Comment]) -> Void)? { get set }
    var fetchError: ((Error) -> Void)? { get set }
    var listComment: [Comment] { get set }
}
