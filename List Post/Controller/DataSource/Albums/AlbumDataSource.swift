//
//  AlbumDataSource.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct AlbumDataSource {
    
}

extension AlbumDataSource: AlbumNetworkProvider {
    func spesificAlbums(id: Int, completion: @escaping (NetworkResult<Album>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .album).addAPIRoute(id: id)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    let getAlbum = Album(album: getJSON)
                    DispatchQueue.main.async {
                        completion(.success(getAlbum))
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failed(error))
                    }
                    break
                }
            })
        }
    }
    
    func getAllAlbums(completion: @escaping (NetworkResult<[Album]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .album)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var getAlbums: [Album] = []
                    
                    for getAlbum in getJSON.arrayValue {
                        getAlbums.append(Album(album: getAlbum))
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(getAlbums))
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failed(error))
                    }
                    break
                }
            })
        }
    }
    
    func getUserAlbums(user id: Int, completion: @escaping (NetworkResult<[Album]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .user).addAPIRoute(id: id).addAPIRoute(path: .album)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var getAlbums: [Album] = []
                    
                    for getAlbum in getJSON.arrayValue {
                        getAlbums.append(Album(album: getAlbum))
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(getAlbums))
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failed(error))
                    }
                    break
                }
            })
        }
    }
    
    
}
