//
//  NetworkResult.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failed(Error)
}
