//
//  ImageCollectionViewCell.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.baseView.layer.cornerRadius = 10.0
        self.baseView.clipsToBounds = true
    }
    
    func populateViewWith(data: PhotoModel) {
        self.imageTitle.text = data.title
        let url = "https://farm\(data.farm).static.flickr.com/\(data.serverId)/\(data.id)_\(data.secretKey).jpg"
//        self.imageView.download(from: url)
        self.imageView.cacheImage(urlString: url)
    }
}
