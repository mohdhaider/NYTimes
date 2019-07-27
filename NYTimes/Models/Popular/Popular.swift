//
//  Popular.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

struct Popular: Codable {
    
    let url : String?
    let column : String?
    let section : String?
    let byline : String?
    let type : String?
    let title : String?
    let abstract : String?
    let published_date : String?
    let source : String?
    let id : Int?
    let asset_id : Int?
    let views : Int?
    let media : [Media]?
    let uri : String?
    
    enum CodingKeys: String, DecodingHelper, CodingKey {
        
        typealias Keys = CodingKeys
        
        case url = "url"
        case column = "column"
        case section = "section"
        case byline = "byline"
        case type = "type"
        case title = "title"
        case abstract = "abstract"
        case published_date = "published_date"
        case source = "source"
        case id = "id"
        case asset_id = "asset_id"
        case views = "views"
        case media = "media"
        case uri = "uri"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        column = try values.decodeIfPresent(String.self, forKey: .column)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        byline = try values.decodeIfPresent(String.self, forKey: .byline)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        asset_id = try values.decodeIfPresent(Int.self, forKey: .asset_id)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        uri = try values.decodeIfPresent(String.self, forKey: .uri)
        
        if let _ = CodingKeys.getStringValue(values, key: .media){
            media = nil
        } else {
            media = try values.decodeIfPresent([Media].self, forKey: .media)
        }
    }
}

extension Popular: MostPopularCellContentProtocol {
    
    var imageUrl: String? {
        return media?.first?.mediaMetadata?.first?.url
    }
    
    var heading: String? {
        return title
    }
    
    var content: String? {
        return byline
    }
    
    var date: String? {
        return published_date
    }
}

