//
//  TrendingMovieService.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Alamofire

class TrendingMovieService {

    class func trendingMovies(page: Pagination, callback: @escaping ([MediaObjectViewModel])->()) {
        var mediaObjectViewModels: [MediaObjectViewModel] = []
        print(page)
        Alamofire.request(TraktRouter.moviesTrending(pagination: page, extendedInfo: .full)).responseCollection {
            (response: DataResponse<[StandardMediaObject]>) in
            if let error = response.error {
                print(error)
            }
            if let standardMediaObjects = response.result.value {
                let group = DispatchGroup()
                standardMediaObjects.forEach { (smo) in
                    group.enter()
                    print("enter")
                    Alamofire.request(FanArtRouter.movie(ids: smo.ids)).responseObject {
                        (response: DataResponse<MovieMediaObjectImages>) in
                        if let error = response.error {
                            print(error)
                        }
                        if let mediaObjects = response.result.value {
                            guard
                                let posterImage = mediaObjects.moviePoster?.first,
                                let thumbImage = mediaObjects.movieThumb?.first
                            else {
                                group.leave()
                                return
                            }
                            if let mediaObject = MediaObjectViewModel(
                                standardMediaObject: smo,
                                posterImage: posterImage,
                                thumbImage: thumbImage){
                                mediaObjectViewModels.append(mediaObject)
                            }
                        }
                        group.leave()
                        print("leave")
                    }
                }
                group.notify(queue: DispatchQueue.main) {
                    print("calling callback")
                    callback(mediaObjectViewModels)
                }
            }
        }
    }
    
}
