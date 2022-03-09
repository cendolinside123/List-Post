//
//  ListPostVMGuideline.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

protocol ListPostVMGuideline {
    func loadListPost(try reloadTime: Int)
    var postResult: (([Post]) -> Void)? { get set }
    var fetchError: ((Error) -> Void)? { get set }
    var listPost: [Post] { get set }
}


struct UseCaseListPost {
    let postDataSource: PostNetworkProvider
    let userDataSource: UserNetworkProvider
}
