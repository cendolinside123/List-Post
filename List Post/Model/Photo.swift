//
//  Photo.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON

struct Photo {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

extension Photo {
    init(photo getJSON: JSON) {
        albumId = getJSON["albumId"].intValue
        id = getJSON["id"].intValue
        title = getJSON["title"].stringValue
        url = getJSON["url"].stringValue
        thumbnailUrl = getJSON["thumbnailUrl"].stringValue
    }
}
