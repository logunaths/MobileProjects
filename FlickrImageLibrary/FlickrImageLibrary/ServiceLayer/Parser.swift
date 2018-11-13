//
//  Parser.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import Foundation

class Parser: NSObject {
    
    static func imageGalleryParser(data: [String:Any]?) -> ImageModel? {
        guard let responseData = data else {
            return nil
        }
        let imageModel = ImageModel.init(response: responseData)
        return imageModel
    }
}
