//
//  PostNetworkProfider.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

protocol PostNetworkProvider {
    
    func getAllPost(completion: @escaping (NetworkResult<[Post]>) -> Void)
    func getSpesificPost(id: Int, completion: @escaping (NetworkResult<Post>) -> Void)
}
