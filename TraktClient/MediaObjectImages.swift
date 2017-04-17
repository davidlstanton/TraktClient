//
//  MediaObjectImages.swift
//  TraktClient
//
//  Created by David on 17/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

final class MediaObjectImages: ResponseObjectSerializable, CustomStringConvertible {
    
    let name: String
    let tmdb: Int?
    let imdb: String?
    
    let hdMovieClearArt: [MediaObjectImage]?
    let moviePoster: [MediaObjectImage]?
    let hdmovieLogo: [MediaObjectImage]?
    let movieBackground: [MediaObjectImage]?
    let movieDisk: [MediaObjectImage]?
    let movieArt: [MediaObjectImage]?
    let movieThumb: [MediaObjectImage]?
    let movieLogo: [MediaObjectImage]?
    let movieBanner: [MediaObjectImage]?
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let rep = representation as? [String: Any],
            let name = rep["name"] as? String
        else { return nil }
        tmdb = representation as? Int
        imdb = representation as? String
        
        hdMovieClearArt = MediaObjectImage(response: response, representation: rep["hdmovieclearart"])
        moviePoster = MediaObjectImage(response: response, representation: rep["movieposter"])
        hdmovieLogo = MediaObjectImage(response: response, representation: rep["hdmovielogo"])
        movieBackground = MediaObjectImage(response: response, representation: rep["moviebackground"])
        movieDisk = MediaObjectImage(response: response, representation: rep["moviedisc"])
        movieArt = MediaObjectImage(response: response, representation: rep["movieart"])
        movieThumb = MediaObjectImage(response: response, representation: rep["moviethumb"])
        movieLogo = MediaObjectImage(response: response, representation: rep["movielogo"])
        movieBanner = MediaObjectImage(response: response, representation: rep["moviebanner"])
        
    }
    
    var description: String {
        var descriptionComponents: [String] = ["name: " + name]
        if let tmdb = tmdb {
            descriptionComponents.append("tmdb: " + tmdb.description)
        }
        if let imdb = imdb {
            descriptionComponents.append("imdb: " + imdb)
        }
        if let hdMovieClearArt = hdMovieClearArt {
            descriptionComponents.append("hdMovieClearArt:\n" + hdMovieClearArt.description)
        }
        if let moviePoster = moviePoster {
            descriptionComponents.append("moviePoster:\n" + moviePoster.description)
        }
        if let hdmovieLogo = hdmovieLogo {
            descriptionComponents.append("hdmovieLogo:\n" + hdmovieLogo.description)
        }
        if let movieBackground = movieBackground {
            descriptionComponents.append("movieBackground:\n" + movieBackground.description)
        }
        if let movieDisk = movieDisk {
            descriptionComponents.append("movieDisk:\n" + movieDisk.description)
        }
        if let movieArt = movieArt {
            descriptionComponents.append("movieArt:\n" + movieArt.description)
        }
        if let movieThumb = movieThumb {
            descriptionComponents.append("movieThumb:\n" + movieThumb.description)
        }
        if let movieLogo = movieLogo {
            descriptionComponents.append("movieLogo:\n" + movieLogo.description)
        }
        if let movieBanner = movieBanner {
            descriptionComponents.append("movieBanner:\n" + movieBanner.description)
        }
        return descriptionComponents.flatMap({$0}).joined(separator: "\n")
    }
    
}
