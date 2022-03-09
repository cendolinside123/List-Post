//
//  Constant.swift
//  List Post
//
//  Created by Jan Sebastian on 07/03/22.
//

import Foundation

struct Constant {
    static let url: String = "https://jsonplaceholder.typicode.com"
}

enum Route: String {
    case post = "/post"
    case user = "/users"
    case album = "/albums"
    case photos = "/photos"
}
