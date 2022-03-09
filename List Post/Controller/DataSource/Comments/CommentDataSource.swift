//
//  CommentDataSource.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommentDataSource {
    
}

extension CommentDataSource: CommentNetworkProvider {
    func getAllComments(completion: @escaping (NetworkResult<[Comment]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .comments)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler:  { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var listComment: [Comment] = []
                    
                    for getComment in getJSON.arrayValue {
                        listComment.append(Comment(comment: getComment))
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(listComment))
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
    
    func getCommentOfPost(id: Int, completion: @escaping (NetworkResult<[Comment]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .post).addAPIRoute(id: id).addAPIRoute(path: .comments)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler:  { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var listComment: [Comment] = []
                    
                    for getComment in getJSON.arrayValue {
                        listComment.append(Comment(comment: getComment))
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(listComment))
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
