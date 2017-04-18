//
//  FanArtAssetRouter.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
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
        return try URLRequest(url: url.asURL())
    }
}
