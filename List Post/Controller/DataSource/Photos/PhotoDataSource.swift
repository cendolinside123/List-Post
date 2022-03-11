//
//  PhotoDataSource.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct PhotoDataSource {
    
}
extension PhotoDataSource: PhotoNetworkProvider {
    func getAllPhotos(completion: @escaping (NetworkResult<[Photo]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .photos)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var getPhotos: [Photo] = []
                    
                    for getPhoto in getJSON.arrayValue {
                        getPhotos.append(Photo(photo: getPhoto))
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(getPhotos))
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
    
    func getPhotoAlbums(album id: Int, completion: @escaping (NetworkResult<[Photo]>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .album).addAPIRoute(id: id).addAPIRoute(path: .photos)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var getPhotos: [Photo] = []
                    
                    for getPhoto in getJSON.arrayValue {
                        getPhotos.append(Photo(photo: getPhoto))
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(getPhotos))
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
    
    func spesificPhoto(id: Int, completion: @escaping (NetworkResult<Photo>) -> Void) {
        DispatchQueue.global().async {
            let url = Constant.url.addAPIRoute(path: .photos).addAPIRoute(id: id)
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    let getPhoto = Photo(photo: getJSON)
                    
                    DispatchQueue.main.async {
                        completion(.success(getPhoto))
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
