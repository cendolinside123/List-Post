//
//  Post.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON

struct Post {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    var userInfo: User?
}

extension Post {
    
    init(post getJSON: JSON) {
        userId = getJSON["userId"].intValue
        id = getJSON["id"].intValue
        title = getJSON["title"].stringValue
        body = getJSON["body"].stringValue
        userInfo = nil
    }
    
    mutating func addUserInfo(user getJSON: JSON) {
        userInfo = User(user: getJSON)
    }
    
    mutating func addUserInfo(user: User) {
        userInfo = user
    }
    
}


