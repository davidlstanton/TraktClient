//
//  FanArtRouter.swift
//  TraktClient
//
//  Created by David on 17/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Alamofire

enum FanArtRouter: URLRequestConvertible {

    static let baseURL = "https://webservice.fanart.tv"
    static let apiKey = "3d131d797ffe307c4308957f70f07d72"
    static let apiVersion = "2"
    
    case movie(ids: StandardMediaObjectIds)
    
    func asURLRequest() throws -> URLRequest {
        let path: String = {
            switch (self) {
            case let .movie(ids):
                var urlPath = "/v3/movies/"
                if let imdb = ids.imdb {
                    urlPath += String(imdb)
                } else if let tmdb = ids.tmdb {
                    urlPath += String(tmdb)
                }
                return urlPath
            }
        }()
        
        let url = try FanArtRouter.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.setValue(FanArtRouter.apiKey, forHTTPHeaderField: "api-key")
        return try URLEncoding.default.encode(urlRequest, with: nil)
    }
}
