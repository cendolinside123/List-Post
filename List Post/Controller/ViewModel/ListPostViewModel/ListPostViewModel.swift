//
//  ListPostViewModel.swift
//  List Post
//
//  Created by Jan Sebastian on 09/03/22.
//

import Foundation

class ListPostViewModel {
    var postResult: (([Post]) -> Void)?
    var fetchError: ((Error) -> Void)?
    var listPost: [Post] = []
    
    private var useCase: UseCaseListPost
    
    init(useCase: UseCaseListPost) {
        self.useCase = useCase
    }
    
}

extension ListPostViewModel: ListPostVMGuideline {
    func loadListPost(try reloadTime: Int) {
        var listPost: [Post] = []
        let group = DispatchGroup()
        var errorMessage: Error? = nil
        group.enter()
        self.useCase.postDataSource.getAllPost(completion: { response in
            switch response {
            case .success(let data):
                listPost = data
                group.leave()
            case .failed(let error):
//                self?.fetchError?(error)
                errorMessage = error
                group.leave()
                return
            }
            
        })
        
        group.notify(queue: .global(), execute: { [weak self] in
            
            if listPost.count == 0 || errorMessage != nil{
                if reloadTime > 0 {
                    self?.loadListPost(try: reloadTime - 1)
                    return
                } else {
                    self?.fetchError?(errorMessage ?? ErrorResponse.loadFailed)
                    return
                }
                
            }
            let group2 = DispatchGroup()
            for index in 0...listPost.count - 1 {
                group2.enter()
                self?.useCase.userDataSource.getSpesificUser(id: listPost[index].userId, completion: { response in
                    switch response {
                    case .success(let user):
                        listPost[index].addUserInfo(user: user)
                        
                    case .failed(let error):
                        print("getSpesificUser(id:completion:) error \(error.localizedDescription)")
                    }
                    group2.leave()
                })
            }
            
            group2.notify(queue: .main, execute: { [weak self] in
                self?.listPost = listPost
                self?.postResult?(listPost)
            })
            
            
            
            
        })
        
    }
    
    
}
