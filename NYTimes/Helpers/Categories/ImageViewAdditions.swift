//
//  ImageViewAdditions.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(forUrl strUrl: String?, placeholderImage: UIImage?) {
        
        self.image = nil
        guard let url = strUrl, let imageUrl = URL(string: url) else {
            return
        }
        
        let resource = ImageResource(downloadURL: imageUrl, cacheKey: url)
        kf.setImage(with: resource)
    }
}

