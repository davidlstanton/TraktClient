//
//  TrendingMovieService.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import Alamofire

class TrendingMovieService {

    class func trendingMovies(page: Pagination, callback: @escaping ([MediaObjectViewModel])->()) {
        var mediaObjectViewModels: [MediaObjectViewModel] = []
        
        Alamofire.request(TraktRouter.moviesTrending(pagination: page, extendedInfo: .full)).responseCollection {
            (response: DataResponse<[StandardMediaObject]>) in
            if let standardMediaObjects = response.result.value {
                let group = DispatchGroup()
                standardMediaObjects.forEach { (smo) in
                    group.enter()
                    Alamofire.request(FanArtRouter.movie(ids: smo.ids)).responseObject {
                        (response: DataResponse<MovieMediaObjectImages>) in
                        if let mediaObjects = response.result.value {
                            guard
                                let posterImage = mediaObjects.moviePoster?.first,
                                let thumbImage = mediaObjects.movieThumb?.first
                            else { return }
                            if let mediaObject = MediaObjectViewModel(
                                standardMediaObject: smo,
                                posterImage: posterImage,
                                thumbImage: thumbImage){
                                mediaObjectViewModels.append(mediaObject)
                            }
                        }
                        group.leave()
                    }
                }
                group.notify(queue: DispatchQueue.main) {
                    callback(mediaObjectViewModels)
                }
            }
        }
    }
    
}
