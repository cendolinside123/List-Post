//
//  PostDataSource.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct PostDataSource {
    
}

extension PostDataSource: PostNetworkProvider {
    func getAllPost(completion: @escaping (NetworkResult<[Post]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .post)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler:  { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var listPost: [Post] = []
                    
                    for getPost in getJSON.arrayValue {
                        listPost.append(Post(post: getPost))
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(listPost))
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failed(error))
                    }
                    break
                }
            })
        }
    }
    
    func getSpesificPost(id: Int, completion: @escaping (NetworkResult<Post>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .post).addAPIRoute(id: id)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    let getPost = Post(post: getJSON)
                    DispatchQueue.main.async {
                        completion(.success(getPost))
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failed(error))
                    }
                    break
                }
            })
        }
    }
    
    
}

