//
//  Pagination.swift
//  TraktClient
//
//  Created by David on 17/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Alamofire

struct Pagination: CustomStringConvertible {
    let page: Int
    let limit: Int
    
    init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }
    
    var parameters : Parameters {
        return ["page" : page, "limit" : limit]
    }
    
    var description: String {
        return "page: \(page)\nlimit: \(limit)"
    }
}
