//
//  RequestParametersInfo.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

enum RequestFeature {
    case request
    case requestWithParameters(encoding: ParametersEncodign, urlParameters: Parameters, bodyParameters: Parameters, headers: Parameters)
}
