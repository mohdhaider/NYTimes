//
//  RequestInfo.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

enum HTTPType: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestInfo {
    var httpType: HTTPType {get}
    var requestURL: URL {get}
    var requestType: RequestFeature {get}
}
