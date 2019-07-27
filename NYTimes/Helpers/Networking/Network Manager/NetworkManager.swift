//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    func fetchSearch(_ interactor:NetworkInteractor<SearchRequest>,_ info: SearchRequest, completionBlock: @escaping NetworkRequestCompletion) {
        
        interactor.request(info) { (data, response, error) in
            
            completionBlock(data, response, error)
        }
    }
}
