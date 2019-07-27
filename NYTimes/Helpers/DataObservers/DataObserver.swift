//
//  DataObserver.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

struct DataObserver<Element> {
    
    typealias Listner = (Element) -> ()
    private var listners = [Listner]()
    
    var value: Element {
        didSet{
            listners.forEach{ $0(value) }
        }
    }
    
    init(_ val: Element) {
        value = val
    }
    
    mutating func bind(_ listner: Listner?) {
        
        guard let listnerAvail = listner else { return }
        
        listners.append(listnerAvail)
    }
}
