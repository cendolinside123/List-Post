//
//  ListPhotosVMGuideline.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

protocol ListPhotosVMGuideline {
    func loadPhotos(id albumID: Int, try reloadTime: Int)
    var photosResult: (([Photo]) -> Void)? { get set }
    var fetchError: ((Error) -> Void)? { get set }
    var listPhotos: [Photo] { get set }
}

