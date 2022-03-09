//
//  Album.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation
import SwiftyJSON

struct Album {
    let userId: Int
    let id: Int
    let title: String
    var listThumbnailUrl: [Photo]
}

extension Album {
    init(album getJSON: JSON) {
        userId = getJSON["userId"].intValue
        id = getJSON["id"].intValue
        title = getJSON["title"].stringValue
        listThumbnailUrl = []
    }
    
    mutating func updateThumbnail(photos listPhoto: [Photo]) {
        listThumbnailUrl = listPhoto
    }
}

