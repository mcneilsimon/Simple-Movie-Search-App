//
//  Extensions.swift
//  MovieSearch
//
//  Created by Simon Mc Neil on 2018-04-21.
//  Copyright © 2018 Simon Mc Neil. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    func downloadedImage(link: String) {
        
        /*
        let MB = 1024 * 1024
        let day: TimeInterval = 24 * 60 * 60
        
        // create caching image synchronizer
        let imageCache = URLCache(memoryCapacity: 100 * MB, diskCapacity: 100 * MB, diskPath: "images")
        let imageSynchronizer = Synchronizer(cacheTime: day, URLCache: imageCache)
        
        
        // load image into image view
        let cancelationBlock = imageSynchronizer.loadResource(ImageResource(URL: link)) { (object) in
            if case .Success(let image) = object {
                self.image = UIImage(data: image!)
            }
        }*/
     
        guard let url = URL(string: link) else {
            return
        }
        
        image = nil
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async() {
                self.image = UIImage(data: data!)
            }
        }.resume()
    }
}



















