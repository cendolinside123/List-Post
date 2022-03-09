//
//  ListAlbumsVMGuideline.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

protocol ListAlbumsVMGuideline {
    func loadUserAlbums(id userID: Int, try reloadTime: Int)
    var albumsResult: (([Album]) -> Void)? { get set }
    var fetchError: ((Error) -> Void)? { get set }
    var listAlbums: [Album] { get set }
}

struct UseCaseListAlbum {
    let albumDataSource: AlbumNetworkProvider
    let photoDataSource: PhotoNetworkProvider
}
