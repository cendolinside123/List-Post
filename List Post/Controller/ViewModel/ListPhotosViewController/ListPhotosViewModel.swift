//
//  ListPhotosViewModel.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

class ListPhotosViewModel {
    var photosResult: (([Photo]) -> Void)?
    var fetchError: ((Error) -> Void)?
    var listPhotos: [Photo] = []
    
    private var useCase: PhotoNetworkProvider
    
    init(useCase: PhotoNetworkProvider) {
        self.useCase = useCase
    }
    
}
extension ListPhotosViewModel: ListPhotosVMGuideline {
    func loadPhotos(id albumID: Int, try reloadTime: Int) {
        self.useCase.getPhotoAlbums(album: albumID, completion: { [weak self] response in
            switch response {
            case .success(let data):
                self?.listPhotos = data
                self?.photosResult?(data)
            case .failed(let error):
                self?.fetchError?(error)
            }
        })
    }
    
    
}
