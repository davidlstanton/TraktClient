//
//  FanArtAssetRouter.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Alamofire

enum FanArtAssetRouter: URLRequestConvertible {
    case preview(urlString: String), full(urlString: String)
    
    func asURLRequest() throws -> URLRequest {
        
        var url: String {
            switch self {
                case let .full(urlString):
                    return urlString
                case let .preview(urlString):
                    return urlString.replacingOccurrences(of: "/fanart/", with: "/preview/")
            }
        }
        let sslUrl = url.replacingOccurrences(of: "http://", with: "https://")
        return try URLRequest(url: sslUrl.asURL())
    }
}
