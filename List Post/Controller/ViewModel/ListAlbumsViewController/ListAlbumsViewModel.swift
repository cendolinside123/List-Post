//
//  ListAlbumsViewModel.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

class ListAlbumsViewModel {
    var albumsResult: (([Album]) -> Void)?
    var fetchError: ((Error) -> Void)?
    var listAlbums: [Album] = []
    private var useCase: UseCaseListAlbum
    
    init(useCase: UseCaseListAlbum) {
        self.useCase = useCase
    }
    
}
extension ListAlbumsViewModel: ListAlbumsVMGuideline {
    func loadUserAlbums(id userID: Int, try reloadTime: Int) {
        var listAlbums: [Album] = []
        let group = DispatchGroup()
        var errorMessage: Error? = nil
        
        group.enter()
        self.useCase.albumDataSource.getUserAlbums(user: userID, completion: { response in
            switch response {
            case .success(let data):
                listAlbums = data
            case .failed(let error):
                errorMessage = error
            }
            group.leave()
        })
        
        group.notify(queue: .global(), execute: { [weak self] in
            
            if reloadTime > 0 {
                if errorMessage != nil {
                    self?.loadUserAlbums(id: userID, try: reloadTime - 1)
                    return
                }
                
            } else {
                self?.fetchError?(errorMessage ?? ErrorResponse.loadFailed)
                return
            }
            
            let group2 = DispatchGroup()
            
            for index in 0...listAlbums.count - 1 {
                group2.enter()
                self?.useCase.photoDataSource.getPhotoAlbums(album: listAlbums[index].id, completion: { response in
                    switch response {
                    case .success(let photos):
                        
                        if photos.count >= 6 {
                            listAlbums[index].updateThumbnail(photos: Array(photos[0..<6]))
                        } else {
                            listAlbums[index].updateThumbnail(photos: photos)
                        }
                        
                    case .failed(let error):
                        print("getSpesificUser(id:completion:) error \(error.localizedDescription)")
                    }
                    group2.leave()
                })
            }
            
            group2.notify(queue: .main, execute: { [weak self] in
                self?.listAlbums = listAlbums
                self?.albumsResult?(listAlbums)
            })
            
        })
        
    }
    
    
}


