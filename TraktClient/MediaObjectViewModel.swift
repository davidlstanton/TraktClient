//
//  MediaObjectView.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import IGListKit

class MediaObjectViewModel: IGListDiffable, CustomStringConvertible {

    let traktId: Int
    let title: String
    let year: Int
    let overview: String
    let rating: Double
    let genres: [String]
    let posterUrlString: String
    let thumbUrlString: String
    
    init?(standardMediaObject: StandardMediaObject, posterImage: MediaObjectImage, thumbImage: MediaObjectImage) {
        traktId = standardMediaObject.ids.trakt
        title = standardMediaObject.title
        year = standardMediaObject.year
        guard
            let overview = standardMediaObject.overview,
            let rating = standardMediaObject.rating,
            let genres = standardMediaObject.genres
        else { return nil }
        self.overview = overview
        self.rating = rating
        self.genres = genres
        posterUrlString = posterImage.url
        thumbUrlString = thumbImage.url
    }
    
    init(traktId: Int,
         title: String,
         year: Int,
         overview: String,
         rating: Double,
         genres: [String],
         posterUrlString: String,
         thumbUrlString: String) {
        self.traktId = traktId
        self.title = title
        self.year = year
        self.overview = overview
        self.rating = rating
        self.genres = genres
        self.posterUrlString = posterUrlString
        self.thumbUrlString = thumbUrlString
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(integerLiteral: traktId)
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if let object = object as? MediaObjectViewModel {
            if Double(object.traktId) + object.rating == Double(traktId) + rating {
                if (object.title + object.overview + object.posterUrlString + object.thumbUrlString) ==
                    (title + overview + posterUrlString + thumbUrlString) {
                    return true
                }
            }
        }
        return false
    }
    
    var description: String {
        return "traktId: \(traktId)\ntitle: \(title)\nyear: \(year)\noverview: \(overview)\nrating: \(rating)\ngenres: \(genres.flatMap({$0}).joined(separator: ", "))\nposterUrlString: \(posterUrlString)\nthumbUrlString: \(thumbUrlString)"
    }
}
