//
//  StandardMediaObjectType.swift
//  TraktClient
//
//  Created by David on 10/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

enum StandardMediaObjectType: String {
    case movie = "movie", show = "show", season = "season", episode = "episode", person = "person"
    init?(type:String) {
        switch(type) {
            case "movie": self = .movie
            case "show": self = .show
            case "season": self = .season
            case "episode": self = .episode
            case "person": self = .person
        default: return nil
        }
    }
    static func all() -> [StandardMediaObjectType] {
        return [.movie, .show, .season, .episode, .person]
    }
}
