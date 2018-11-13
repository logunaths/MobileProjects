
//
//  APPConfig.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import Foundation

struct Config {
    static let host = "https://api.flickr.com/services/rest/?"
    static let serverPath = "method=flickr.photos.search&"
    static let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736&"
    static let serverParameters = "format=json&nojsoncallback=1&safe_search=1&text="
    static let imageGalleryURL = Config.host + Config.serverPath + "api_key=" + Config.apiKey + Config.serverParameters
    static let page = "&page="
    static let mockyURL = "https://www.mocky.io/v2/5beaaf882f00006300da3bd9"
}
