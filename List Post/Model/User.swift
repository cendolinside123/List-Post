//
//  User.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON

struct User {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

extension User {
    init(user getJSON: JSON) {
        id = getJSON["id"].intValue
        name = getJSON["name"].stringValue
        username = getJSON["username"].stringValue
        email = getJSON["email"].stringValue
        address = Address(address: getJSON["address"])
        phone = getJSON["phone"].stringValue
        website = getJSON["website"].stringValue
        company = Company(company: getJSON["company"])
    }
}

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geographic
}

extension Address {
    init(address getJSON: JSON) {
        street = getJSON["street"].stringValue
        suite = getJSON["suite"].stringValue
        city = getJSON["city"].stringValue
        zipcode = getJSON["zipcode"].stringValue
        geo = Geographic(geo: getJSON["geo"])
    }
}

struct Geographic {
    let lat: String
    let lng: String
}

extension Geographic {
    init(geo getJSON: JSON) {
        lat = getJSON["lat"].stringValue
        lng = getJSON["lng"].stringValue
    }
}

struct Company {
    let name: String
    let catchPhrase: String
    let bs: String
}

extension Company {
    init(company getJSON: JSON) {
        name = getJSON["name"].stringValue
        catchPhrase = getJSON["catchPhrase"].stringValue
        bs = getJSON["bs"].stringValue
    }
}
