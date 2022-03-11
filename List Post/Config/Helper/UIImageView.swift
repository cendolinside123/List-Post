//
//  UIImageView.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    func setImage(url: String, times: Int = 3) {
        
        image = #imageLiteral(resourceName: "loading")
        
        guard let getURL = URL(string: url) else {
            return
        }
        let imageResource = ImageResource(downloadURL: getURL, cacheKey: url)
        
        let groupLoad = DispatchGroup()
        groupLoad.enter()
        let getFrameSize = self.frame.size
        DispatchQueue.global().async {
            KingfisherManager.shared.retrieveImage(with: imageResource , options: [
                .processor(DownsamplingImageProcessor(size: getFrameSize)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]) { result in
                switch result{
                case .success(_):
                    print("cache success : \(url)")
                case .failure(let error):
                    print("cache failed : \(error.localizedDescription) url : \(url)")
                }
                groupLoad.leave() // MARK: NOTE FOR REVIEWER: Please give me a feedback is there're crash/bug happend on setImage(url:times:)
            }
        }
        
        // start
        
        groupLoad.notify(queue: .main, execute: {
            DispatchQueue.global().async {
                ImageClassManager.sharedInstance.initialize().retrieveImage(forKey:"\(url)", options: [
                    .transition(.fade(10.0)),
                    .loadDiskFileSynchronously,
                    .forceTransition
                ]){[weak self] result in
                    switch result {
                        case .success(let value):
                            DispatchQueue.main.async {
                                self?.contentMode = .scaleAspectFill
                                if value.cacheType == .disk{
                                    //self?.image = ThemeManager.shared.songPlaceholder
                                    print("cache local type \(value.cacheType) url:  \(url)")
                                    
                                    if let cacheImage = value.image{
                                        self?.image = cacheImage
                                    }
                                    else{
                                        self?.image = #imageLiteral(resourceName: "loading")
                                    }
                                    return
                                }
                                else{
                                    print("cache local type \(value.cacheType) url: \(url)")
                                    self?.image = #imageLiteral(resourceName: "loading")
                                    if times > 0 {
                                        self?.setImage(url: url, times: times - 1)
                                        return
                                    }
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            if times > 0 {
    //                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
    //                                self?.image = #imageLiteral(resourceName: "loading")
    //                            })
                                self?.image = #imageLiteral(resourceName: "loading")
                                self?.setImage(url: url, times: times - 1)
                                return
                            } else {
                                print("failed to download song url: \(url)")
                            }
                        }
                    }
            }
            // end
        })
        
        
        
    }
}


class ImageClassManager{
    private var cache:ImageCache?
    
    static let sharedInstance = ImageClassManager()
    
    
    func initialize() -> ImageCache{
        if let checkInitialize = cache{
            return checkInitialize
        }
        else{
            let setupCache = ImageCache.default
            // setupCache.memoryStorage.config.countLimit = 1000 * 1024 * 1024
            setupCache.memoryStorage.config.totalCostLimit = 1
            setupCache.diskStorage.config.expiration = .days(3)
//            setupCache.calculateDiskStorageSize(completion: {result in
//
//            })
            self.cache = setupCache
            
            return self.cache!
        }
    }
}

