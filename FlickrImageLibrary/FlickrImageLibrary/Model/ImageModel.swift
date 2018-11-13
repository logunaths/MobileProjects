//
//  ImageModel.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import Foundation

//MARK:- Data mnodel for photos gallery
class ImageModel: NSObject {
    var pageCount: Int
    var totalPages: Int
    var photos: [PhotoModel]
    
    override init() {
        self.pageCount = 0
        self.totalPages = 0
        self.photos = []
    }
    
    convenience init(response: [String:Any]) {
        /// Invoke the default initalizer
        self.init()
        
        /// Check if the value is not empty
        guard let value = response["photos"] as? [String:Any]  else {
            return
        }
        if let pageCount = value["page"] as? Int{
            self.pageCount = pageCount
        }
        if let totalPages = value["pages"] as? Int {
            self.totalPages = totalPages
        }
        if let value = value["photo"] as? [Any]{
            for photo in value{
                self.photos.append(PhotoModel.init(data: photo as! [String:Any]))
            }
        }
    }
}


//MARK:- Data model for photos
class PhotoModel: NSObject {
    
    var id: String
    var owner: String
    var secretKey: String
    var serverId: String
    var farm: Int
    var title: String
    
    override init() {
        self.id = ""
        self.owner = ""
        self.serverId = ""
        self.secretKey = ""
        self.farm = 0
        self.title = ""
    }
    
    convenience init(data: [String:Any]) {
        /// Invoke the default initalizer
        self.init()
        
        /// Check if the value is not empty
        if let value = data["farm"] as? Int {
            self.farm = value
        }
        if let value = data["server"] as? String {
            self.serverId = value
        }
        if let value = data["id"] as? String {
            self.id = value
        }
        if let value = data["secret"] as? String {
            self.secretKey = value
        }
        if let value = data["title"] as? String {
            self.title = value
        }
    }
}

//MARK- Model for request data
struct Query {
    var searchText: String?
    var pageCount: Int?
    
    init() {
        self.searchText =  Constatns.searchDefaultText
        self.pageCount = 1
    }
    
    init(text: String, pageCount: Int) {
        self.searchText =  text
        self.pageCount = pageCount
    }
}
