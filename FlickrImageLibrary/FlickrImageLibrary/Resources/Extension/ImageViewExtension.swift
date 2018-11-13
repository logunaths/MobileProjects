//
//  ImageViewExtension.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import UIKit

/// Create a image cache to store all iamge in disk cache
/// Will use the URL as key while retrieving
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        /// Set the placeholder image
//        image = UIImage.init(named: "loading.gif")
        
        /// Check if the image present in disk cache
        // /Set the image & return if its in cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        /// Procced to download if the image is not present in the cache
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let res = data {
                /// Once image is downloaded, popoulate it in iamge view
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: res)
                    
                    /// Save the image in disk cahce with key as URL
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    
                    ///Set the downloaded image
                    self.image = imageToCache
                }
            }
            }.resume() ///Resume the task to dowload
    }
}
