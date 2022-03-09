//
//  UserNetworkProvider.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

protocol UserNetworkProvider {
    
    func getAllUser(completion: @escaping (NetworkResult<[User]>) -> Void)
    func getSpesificUser(id: Int, completion: @escaping (NetworkResult<User>) -> Void)
}
