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

enum ErrorResponse: Error, LocalizedError {
    case loadFailed
    
    var errorDescription: String? {
        switch self {
        case .loadFailed:
            return NSLocalizedString(
                "Failed to read/load data",
                comment: ""
            )
        }
    }
}
