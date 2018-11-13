//
//  ImageCollectionCell.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import UIKit

class ImageCollectionCell: UITableViewCell {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var imageModel: ImageModel?
    var loadData: ((Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.registerCustomView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func registerCustomView() {        
        self.imageCollectionView.register(UINib.init(nibName: CustomCellIdentifiers.imageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CustomCellIdentifiers.imageCollectionViewCell)
    }
    
    func setSize(_ size:CGSize) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = size
        flowLayout.minimumInteritemSpacing = 10
        self.imageCollectionView.collectionViewLayout = flowLayout
        self.imageCollectionView.showsHorizontalScrollIndicator = false
        self.imageCollectionView.bounces = false
    }
}

//MARK:- Collectionview delegates and datasources
extension ImageCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellIdentifiers.imageCollectionViewCell, for: indexPath) as! ImageCollectionViewCell
        cell.populateViewWith(data: (self.imageModel?.photos[indexPath.row])! )
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let count = self.imageModel?.photos.count {
            if indexPath.row == count - 3 {
                let pageIndex = (self.imageModel?.pageCount)! + 1
                self.loadData!(pageIndex)
            }
        }
    }
}
