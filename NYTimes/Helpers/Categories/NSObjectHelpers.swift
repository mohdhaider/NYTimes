//
//  NSObjectHelpers.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

extension NSObject {
    
    func moveToMainThread(_ block:(() -> Void)?){
        
        if Thread.isMainThread {
            block?()
        } else {
            DispatchQueue.main.async {
                block?()
            }
        }
    }
}
