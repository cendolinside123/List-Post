//
//  CommentNetworkProvider.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

protocol CommentNetworkProvider {
    func getAllComments(completion: @escaping (NetworkResult<[Comment]>) -> Void)
    func getCommentOfPost(id: Int, completion: @escaping (NetworkResult<[Comment]>) -> Void)
}
