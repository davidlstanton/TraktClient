//
//  StandardMediaObject.swift
//  TraktClient
//
//  Created by David on 06/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

final class StandardMediaObject: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    
    let type: StandardMediaObjectType
    let title: String
    let year: Int
    let ids: StandardMediaObjectIds
    let watchers: Int?
    let tagline: String?
    let overview: String?
    let released: Date?
    let runtime: Int?
    let trailer: String?
    let homepage: String?
    let rating: Double?
    let votes: Int?
    let updated_at: Date?
    let language: String?
    let availibleTranslations: [String]?
    let genres: [String]?
    let certification: String?

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
    
    var description: String {
        var descriptionComponents: [String] = ["type: " + type.description]
        descriptionComponents.append("title: " + title)
        descriptionComponents.append("year: " + year.description)
        descriptionComponents.append("ID's: " + ids.description)
        if let watchers = watchers {
            descriptionComponents.append("watchers: " + watchers.description)
        }
        if let tagline = tagline {
            descriptionComponents.append("tagline: " + tagline)
        }
        if let overview = overview {
            descriptionComponents.append("overview: " + overview)
        }
        if let released = released {
            descriptionComponents.append("released: " + released.description)
        }
        if let runtime = runtime {
            descriptionComponents.append("runtime: " + runtime.description)
        }
        if let trailer = trailer {
            descriptionComponents.append("trailer: " + trailer)
        }
        if let homepage = homepage {
            descriptionComponents.append("homepage: " + homepage)
        }
        if let rating = rating {
            descriptionComponents.append("rating: " + rating.description)
        }
        if let votes = votes {
            descriptionComponents.append("votes: " + votes.description)
        }
        if let updated_at = updated_at {
            descriptionComponents.append("updated_at: " + updated_at.description)
        }
        if let language = language {
            descriptionComponents.append("language: " + language)
        }
        if let availibleTranslations = availibleTranslations {
            descriptionComponents.append("availibleTranslations:\n" + availibleTranslations.flatMap({$0}).joined(separator: "\n"))
        }
        if let genres = genres {
            descriptionComponents.append("genres:\n" + genres.flatMap({$0}).joined(separator: "\n"))
        }
        if let certification = certification {
            descriptionComponents.append("certification: " + certification)
        }
        
        return descriptionComponents.flatMap({$0}).joined(separator: "\n")
    }
    
}









