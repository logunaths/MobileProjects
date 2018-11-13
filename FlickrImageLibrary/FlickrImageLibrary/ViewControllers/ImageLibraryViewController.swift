//
//  ViewController.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import UIKit

class ImageLibraryViewController: UIViewController {
    
    //MARK:- Stroyboard declrations
    @IBOutlet weak var imageLibraryTableView: UITableView!
    @IBOutlet weak var imageQuerySearchBar: UISearchBar!
    
    //MARK:- Class variable declrations
    
    /// Data model object
    var imageGalleryModel: ImageModel?
    
    /// Default text for the search
    var searchText = Constatns.searchDefaultText
    
    /// Request data model
    var query = Query()
    
    //MARK:- Life cylce methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Register the custom cells with the view controllers table view
        self.registerCustomCells()
        self.getImageGalleryData(withQuery: query)
    }
    
    //MARK:- Custom methods
    
    /**
        The below method registers the custom cells with the table view
     */
    private func registerCustomCells() {
        self.imageLibraryTableView.register(UINib.init(nibName: CustomCellIdentifiers.imageCollectionCell, bundle: nil), forCellReuseIdentifier: CustomCellIdentifiers.imageCollectionCell)
        self.imageLibraryTableView.register(UINib.init(nibName: CustomCellIdentifiers.HeaderCell, bundle: nil), forCellReuseIdentifier: CustomCellIdentifiers.HeaderCell)
    }
    
    /**
         The below method communicates with the API cleint to fetch data from the server
     */
    private func getImageGalleryData(withQuery query:Query) {
        let client = APIClient()
        ProgressIndicator.sharedInstance.showIndicator()
        client.getUserData(query: query, completionHandler: {response, error in
            
            //Get the main queue as we are doing operations on the UI
            DispatchQueue.main.async {
                ProgressIndicator.sharedInstance.hideIndicator()
                guard let responseData = response else{
                    return
                }
                /// Load the model with the response data
                if self.imageGalleryModel == nil {
                    /// For first time laoding
                    self.imageGalleryModel = responseData
                } else{
                    /// Append the second apge data with the existing
                    self.imageGalleryModel?.photos.append(contentsOf: responseData.photos)
                }
                self.imageLibraryTableView.reloadData()
            }
        })
    }
}

//MARK:- Tableview Delegates & Datasource methods
extension ImageLibraryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.imageGalleryModel != nil, (self.imageGalleryModel?.photos.count)! > 0 else {
            return 0
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.imageCollectionCell) as! ImageCollectionCell
        
        //S/ Specify the size for collection view cell
        let size = self.getSize()
        cell.setSize(CGSize.init(width: size, height: size))
        
        //Populate the response to the view
        cell.imageModel = self.imageGalleryModel
        
        cell.loadData = { index in
            //Load next set of data if last cell is reached
            let query = Query.init(text: self.searchText, pageCount: index)
            self.query.searchText = self.searchText
            self.query.pageCount = index
            self.getImageGalleryData(withQuery: query)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.imageLibraryTableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifiers.HeaderCell) as! HeaderCell
        
        ///Load the title for header --
        if self.imageGalleryModel != nil && (self.imageGalleryModel?.photos.count)! > 0  {
            cell.titleLabel.text = Constatns.headerText + self.searchText
        }else {
            cell.titleLabel.text = Constatns.loading
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    /// Returns the sixe for image
    func getSize() -> CGFloat {
        return self.view.frame.width/3.25
    }
}

//MARK:- Search bar delegate methods
extension ImageLibraryViewController: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// Check if the user has entered any text, if se procced to search
        if let text = searchBar.text {
            self.searchText = text
            
            /// Search with the user entered text and page count form response
            self.query.searchText = text
            self.query.pageCount = (self.imageGalleryModel?.pageCount ?? 1)
            self.getImageGalleryData(withQuery: self.query)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            self.imageQuerySearchBar.text = ""
            self.imageQuerySearchBar.placeholder = Constatns.placeholder
        }
    }
}

