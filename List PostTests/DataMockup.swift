//
//  DataMockup.swift
//  List PostTests
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON
@testable import List_Post


struct PostMockupDataSource: PostNetworkProvider {
    func getAllPost(completion: @escaping (NetworkResult<[Post]>) -> Void) {
        guard let url = Bundle.main.path(forResource: "posts", ofType: "json") else {
            completion(.failed(ErrorResponse.loadFailed))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
            var listPost: [Post] = []
            
            for getPost in getJSON.arrayValue {
                listPost.append(Post(post: getPost))
            }
            
            completion(.success(listPost))
            
        } catch let error {
            completion(.failed(error))
        }
        
    }
    
    func getSpesificPost(id: Int, completion: @escaping (NetworkResult<Post>) -> Void) {
        guard let url = Bundle.main.path(forResource: "posts", ofType: "json") else {
            completion(.failed(ErrorResponse.loadFailed))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
            var listPost: [Post] = []
            
            for getPost in getJSON.arrayValue {
                listPost.append(Post(post: getPost))
            }
            
            if let getSelectedPost = listPost.filter({ $0.id == id}).first {
                completion(.success(getSelectedPost))
            } else {
                completion(.failed(ErrorResponse.loadFailed))
            }
            
            
            
        } catch let error {
            completion(.failed(error))
        }
    }
    
    
}

struct UserMockupDataSource: UserNetworkProvider {
    func getAllUser(completion: @escaping (NetworkResult<[User]>) -> Void) {
        guard let url = Bundle.main.path(forResource: "posts", ofType: "json") else {
            completion(.failed(ErrorResponse.loadFailed))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
            var listUser: [User] = []
            
            for getUser in getJSON.arrayValue {
                listUser.append(User(user: getUser))
            }
            
            completion(.success(listUser))
            
        } catch let error {
            completion(.failed(error))
        }
    }
    
    func getSpesificUser(id: Int, completion: @escaping (NetworkResult<User>) -> Void) {
        guard let url = Bundle.main.path(forResource: "posts", ofType: "json") else {
            completion(.failed(ErrorResponse.loadFailed))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
            var listUser: [User] = []
            
            for getUser in getJSON.arrayValue {
                listUser.append(User(user: getUser))
            }
            
            if let getSelectedUser = listUser.filter({ $0.id == id}).first {
                completion(.success(getSelectedUser))
            } else {
                completion(.failed(ErrorResponse.loadFailed))
            }
            
            
            
        } catch let error {
            completion(.failed(error))
        }
    }
    
    
}
