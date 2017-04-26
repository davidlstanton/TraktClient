//
//  TraktRouter.swift
//  TraktClient
//
//  Created by David on 17/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Alamofire

enum TraktRouter: URLRequestConvertible {

    static let baseURL = "https://api.trakt.tv"
    static let clientId = "0e7e55d561c7e688868a5ea7d2c82b17e59fde95fbc2437e809b1449850d4162"
    static let apiVersion = "2"
    
    case moviesTrending(pagination: Pagination, extendedInfo: ExtendedInfo)
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch (self) {
            case let .moviesTrending(pagination, extendedInfo):
                var parameters: [String: Any]
                parameters = pagination.parameters ;
                extendedInfo.parameters.forEach { (source: (key:String, value: Any)) in
                    parameters[source.key] = source.value
                }
                return 	("/movies/trending", parameters)
            }
        }()
        
        let url = try TraktRouter.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        urlRequest.setValue(TraktRouter.clientId, forHTTPHeaderField: "trakt-api-key")
        urlRequest.setValue(TraktRouter.apiVersion, forHTTPHeaderField: "trakt-api-version")
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }

}
