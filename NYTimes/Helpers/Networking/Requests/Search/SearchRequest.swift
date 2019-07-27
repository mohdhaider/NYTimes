//
//  SearchRequest.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

enum SearchRequest {
    case search(days: Int, searchText: String?)
}

extension SearchRequest : RequestInfo {
    var httpType: HTTPType {
        return .get
    }
    
    var requestURL: URL {
        
        var urlStr = NYTimesApis.baseUrl.rawValue
        
        switch self {
        case .search(let days, _):
            urlStr += "\(days).json"
        }
        
        guard let url = URL(string: urlStr) else { fatalError("Unable to configure url") }
        return url
    }
    
    var requestType: RequestFeature {
        
        let headers =  Parameters()
        let bodyParams =  Parameters()
        var urlParams =  Parameters()
        
        switch self {
        case .search(_, _):
            urlParams["api-key"] = NYTimesKeys.apiKey.rawValue
        }
        
        return .requestWithParameters(encoding: .urlEncoding, urlParameters: urlParams, bodyParameters: bodyParams, headers: headers)
    }
}
//https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=Xqr7C1h45kOy745fHfeDFz1i1B2T8px0
