//
//  Utilities.swift
//  FlickrImageLibrary
//
//  Created by Logu Subramaniyan on 13/11/18.
//  Copyright © 2018 Aspire Systems. All rights reserved.
//

import Foundation
import UIKit

/// Activity indicator to show when there are time consuming task
class ProgressIndicator {
    
    /// The shared instance
    static let sharedInstance = ProgressIndicator()
    
    /// The activity indicator view
    let indicatorView = UIView()
    
    /// The window
    let window = UIApplication.shared.keyWindow!
    
    private init() {
        configureIndicator()
    }
    
    /** Configures the style of the indicator.You can set color of the indicator, ring radius, ring thickness, Mask style, etc. */
    private func configureIndicator() {
        self.indicatorView.frame = self.window.frame
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: self.window.frame.size.width/2 - 50, y: self.window.frame.size.height/2 - 50, width: 100, height: 100)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.init(named: "loading.gif")
        self.indicatorView.addSubview(imageView)
    }
    
    /** Use this method to  show the activity indicator from  UIViewContollers/UIView */
    public func showIndicator() {
        self.window.addSubview(self.indicatorView)
    }
    
    /** Use this method to  hide the activity indicator from  UIViewContollers/UIView */
    public func hideIndicator() {
        self.indicatorView.removeFromSuperview()
    }
}
