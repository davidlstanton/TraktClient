//
//  StandardMediaObjectIds.swift
//  TraktClient
//
//  Created by David on 10/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

final class StandardMediaObjectIds: ResponseObjectSerializable, CustomStringConvertible  {

    var trakt: Int
    var slug: String?
    var imdb: String?
    var tmdb: Int?
    var tvdb: Int?
    var tvrage: Int?
    
    init(trakt: Int, slug: String?=nil, imdb:String?=nil, tmdb:Int?=nil, tvdb:Int?=nil, tvrage:Int?=nil) {
        self.trakt = trakt
        self.slug = slug
        self.imdb = imdb
        self.tmdb = tmdb
        self.tvdb = tvdb
        self.tvrage = tvrage
    }
    
    required init?(response: HTTPURLResponse, representation: Any) {
        
        guard
            let representation = representation as? [String: Any],
            let trakt = representation["trakt"] as? Int
        else { return nil }
        
        self.trakt = trakt
        self.slug = representation["slug"] as? String
        self.imdb = representation["imdb"] as? String
        self.tmdb = representation["tmdb"] as? Int
        self.tvdb = representation["tvdb"] as? Int
        self.tvrage = representation["tvrage"] as? Int
        
    }
    
    var description: String {
        var descriptionComponents: [String] = ["trakt: " + trakt.description]
        if let slug = slug {
            descriptionComponents.append("slug: " + slug)
        }
        if let imdb = imdb {
            descriptionComponents.append("imdb: " + imdb)
        }
        if let tmdb = tmdb {
            descriptionComponents.append("tmdb: " + tmdb.description)
        }
        if let tvdb = tvdb {
            descriptionComponents.append("tvdb: " + tvdb.description)
        }
        if let tvrage = tvrage {
            descriptionComponents.append("tvrage: " + tvrage.description)
        }
        return descriptionComponents.flatMap({$0}).joined(separator: "\n")
    }
    
}
