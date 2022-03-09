//
//  Comment.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON

struct Comment {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

extension Comment {
    init(comment getJSON: JSON) {
        postId = getJSON["postId"].intValue
        id = getJSON["id"].intValue
        name = getJSON["name"].stringValue
        email = getJSON["email"].stringValue
        body = getJSON["body"].stringValue
    }
}

extension Comment: Equatable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.postId == rhs.postId &&
        lhs.email == rhs.email &&
        lhs.body == rhs.body
    }
}
