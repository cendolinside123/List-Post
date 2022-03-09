//
//  UserDataSource.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON
import Alamofire

struct UserDataSource {
    
}

extension UserDataSource: UserNetworkProvider {
    func getAllUser(completion: @escaping (NetworkResult<[User]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .user)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler:  { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var listUser: [User] = []
                    
                    for getUser in getJSON.arrayValue {
                        listUser.append(User(user: getUser))
                    }
                    DispatchQueue.main.async {
                        completion(.success(listUser))
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
    
    func getSpesificUser(id: Int, completion: @escaping (NetworkResult<User>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .user).addAPIRoute(id: id)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler:  { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    let getUser = User(user: getJSON)
                    
                    DispatchQueue.main.async {
                        completion(.success(getUser))
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
