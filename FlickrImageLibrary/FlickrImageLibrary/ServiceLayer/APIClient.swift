//
//  APIClient.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import Foundation

public class APIClient {
    
    /**
        This method performs network operation and
        return the result to caller via clsoures
     
        -- parameters: query
     */
    func getUserData(query: Query, completionHandler: @escaping (ImageModel?, Error?) -> () ) {
        
        let urlSession = URLSession.init(configuration: .default)
        let text = query.searchText ?? Constatns.searchDefaultText
        guard let url = URL.init(string: Config.imageGalleryURL + text + Config.page + "\(query.pageCount ?? 1)")  else {
            return
        }
        let urlRequest = URLRequest.init(url: url)
        let task = urlSession.dataTask(with: urlRequest) {(data, response, error)  in
            guard let userData = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: userData, options: []) as? [String:Any]
                let responseData = Parser.imageGalleryParser(data: parsedData)
                completionHandler(responseData, nil)
            }catch{
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
