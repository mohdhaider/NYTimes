//
//  MostPopularCellViewModel.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

struct MostPopularCellViewModel {
    
    var info:MostPopularCellContentProtocol
}

extension MostPopularCellViewModel: MostPopularCellContentProtocol {
    
    var section: String? {
        return info.section
    }
    
    var imageUrl: String? {
        return info.imageUrl
    }
    
    var heading: String? {
        return info.heading
    }
    
    var content: String? {
        return info.content
    }
    
    var date: String? {
        return info.date
    }
}
