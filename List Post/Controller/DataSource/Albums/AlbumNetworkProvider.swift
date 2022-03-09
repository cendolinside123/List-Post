//
//  AlbumNetworkProvider.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

protocol AlbumNetworkProvider {
    func getAllAlbums(completion: @escaping (NetworkResult<[Album]>) -> Void)
    func getUserAlbums(user id: Int, completion: @escaping (NetworkResult<[Album]>) -> Void)
    func spesificAlbums(id: Int, completion: @escaping (NetworkResult<Album>) -> Void)
}
