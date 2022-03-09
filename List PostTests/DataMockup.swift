//
//  DataMockup.swift
//  List PostTests
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON
@testable import List_Post


struct Constant {
    static let commentPost1: [Comment] = [Comment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"), Comment(postId: 1, id: 2, name: "quo vero reiciendis velit similique earum", email: "Jayne_Kuhic@sydney.com", body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et"), Comment(postId: 1, id: 3, name: "odio adipisci rerum aut animi", email: "Nikita@garfield.biz", body: "quia molestiae reprehenderit quasi aspernatur\naut expedita occaecati aliquam eveniet laudantium\nomnis quibusdam delectus saepe quia accusamus maiores nam est\ncum et ducimus et vero voluptates excepturi deleniti ratione"), Comment(postId: 1, id: 4, name: "alias odio sit", email: "Lew@alysha.tv", body: "non et atque\noccaecati deserunt quas accusantium unde odit nobis qui voluptatem\nquia voluptas consequuntur itaque dolor\net qui rerum deleniti ut occaecati"), Comment(postId: 1, id: 5, name: "vero eaque aliquid doloribus et culpa", email: "Hayden@althea.biz", body: "harum non quasi et ratione\ntempore iure ex voluptates in ratione\nharum architecto fugit inventore cupiditate\nvoluptates magni quo et")]
}

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


struct CommentsMockupDataSource: CommentNetworkProvider {
    func getAllComments(completion: @escaping (NetworkResult<[Comment]>) -> Void) {
        guard let url = Bundle.main.path(forResource: "comments", ofType: "json") else {
            completion(.failed(ErrorResponse.loadFailed))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
            var listComment: [Comment] = []
            
            for getComment in getJSON.arrayValue {
                listComment.append(Comment(comment: getComment))
            }
            
            completion(.success(listComment))
            
        } catch let error {
            completion(.failed(error))
        }
    }
    
    func getCommentOfPost(id: Int, completion: @escaping (NetworkResult<[Comment]>) -> Void) {
        guard let url = Bundle.main.path(forResource: "comments", ofType: "json") else {
            completion(.failed(ErrorResponse.loadFailed))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
            var listComment: [Comment] = []
            
            for getComment in getJSON.arrayValue {
                listComment.append(Comment(comment: getComment))
            }
            
            let getCommentPost = listComment.filter({ $0.postId == id})
            
            completion(.success(getCommentPost))
            
        } catch let error {
            completion(.failed(error))
        }
    }
    
    
}
