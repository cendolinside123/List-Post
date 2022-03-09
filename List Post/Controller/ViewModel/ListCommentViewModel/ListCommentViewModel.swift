//
//  ListCommentViewModel.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

class ListCommentViewModel {
    var commentResult: (([Comment]) -> Void)?
    var fetchError: ((Error) -> Void)?
    var listComment: [Comment] = []
    
    private var useCase: CommentNetworkProvider
    
    init(useCase: CommentNetworkProvider) {
        self.useCase = useCase
    }
    
}

extension ListCommentViewModel: ListCommentVMGuideline {
    func loadCommentOfPost(id postID: Int, try reloadTime: Int) {
        self.useCase.getCommentOfPost(id: postID, completion: { [weak self] response in
            switch response {
            case .success(let data):
                self?.listComment = data
                self?.commentResult?(data)
            case .failed(let error):
                if reloadTime > 0 {
                    self?.loadCommentOfPost(id: postID, try: reloadTime - 1)
                } else {
                    self?.fetchError?(error)
                }
            }
        })
    }
    
    
}

