//
//  StandardMediaObject.swift
//  TraktClient
//
//  Created by David on 06/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class StandardMediaObject: NSObject, ResponseObjectSerializable {
    
    var type: StandardMediaObjectType
    var title: String
    var year: Int
    var ids: StandardMediaObjectIds
    var watchers: Int?
    var tagline: String?
    var overview: String?
    var released: Date?
    var runtime: Int?
    var trailer: String?
    var homepage: String?
    var rating: Double?
    var votes: Int?
    var updated_at: Date?
    var language: String?
    var availibleTranslations: [String]?
    var genres: [String]?
    var certification: String?

    init( type: StandardMediaObjectType,
          title: String,
          year: Int,
          ids: StandardMediaObjectIds,
          watchers: Int?,
          tagline: String?,
          overview: String?,
          released: Date?,
          runtime: Int?,
          trailer: String?,
          homepage: String?,
          rating: Double?,
          votes: Int?,
          updated_at: Date?,
          language: String?,
          availableTranslations: [String]?,
          genres: [String]?,
          certification: String?
          ) {
        self.type = type
        self.title = title
        self.year = year
        self.ids = ids
        self.watchers = watchers
        self.tagline = tagline
        self.overview = overview
        self.released = released
        self.runtime = runtime
        self.trailer = trailer
        self.homepage = homepage
        self.rating = rating
        self.votes = votes
        self.updated_at = updated_at
        self.language = language
        self.availibleTranslations = availableTranslations
        self.genres = genres
        self.certification = certification
    }
    
    required init?(response: HTTPURLResponse, representation: Any) {
        
        // First establish the type (needed to access the rest of the data
        
        guard
            let rep = representation as? [String : Any]
        else { return nil }
        // get type
        let types = StandardMediaObjectType.all()
        let type = types.filter { rep[$0.rawValue] != nil }
        if type.count == 1 {
            self.type = type[0]
        } else { return nil }  // doesn't have a valid type (unable to proceed)
        
        //
        self.watchers = rep["watchers"] as? Int
        
        // Extract the rest of the data using type as key
        
        guard
            let representationType = rep[self.type.rawValue] as? [String : Any],
            let title = representationType["title"] as? String,
            let year = representationType["year"] as? Int,
            let ids = StandardMediaObjectIds(response: response, representation: representationType["ids"] as Any)
        else { return nil }
        
        // self.type assigned above
        self.title = title
        self.year = year
        self.ids = ids
        
        //Assign optional fields
        self.watchers = rep["watchers"] as? Int  // NB this fields is not under type
        self.tagline = representationType["tagline"] as? String
        self.overview = representationType["overview"] as? String
        //To Do -  Date self.released = representationType["released"]
        self.runtime = representationType["runtime"] as? Int
        self.trailer = representationType["trailer"] as? String
        self.homepage = representationType["homepage"] as? String
        self.rating = representationType["rating"] as? Double
        self.votes = representationType["votes"] as? Int
        //To Do - Date self.updated_at = representationType["updated_at"]
        self.language = representationType["language"] as? String
        //To Do - Collection self.availibleTranslations = representationType[""]
        //To Do - Collection self.genres = representationType[""]
        self.certification = representationType["certification"] as? String
    }
}









