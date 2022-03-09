//
//  PhotoNetworkProvider.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

protocol PhotoNetworkProvider {
    func getAllPhotos(completion: @escaping (NetworkResult<[Photo]>) -> Void)
    func getPhotoAlbums(album id: Int, completion: @escaping (NetworkResult<[Photo]>) -> Void)
    func spesificPhoto(id: Int, completion: @escaping (NetworkResult<Photo>) -> Void)
}
