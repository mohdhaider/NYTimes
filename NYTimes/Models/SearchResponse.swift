//
//  SearchResponse.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    let status : String?
    let num_results : Int?
    let populars : [Popular]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case num_results = "num_results"
        case populars = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
        populars = try values.decodeIfPresent([Popular].self, forKey: .populars)
    }
}
