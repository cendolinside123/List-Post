//
//  User.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

struct User {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: String
}

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geographic
}

struct Geographic {
    let lat: String
    let lng: String
}

struct Company {
    let name: String
    let catchPhrase: String
    let bs: String
}
