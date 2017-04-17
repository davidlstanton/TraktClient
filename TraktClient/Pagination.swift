//
//  Pagination.swift
//  TraktClient
//
//  Created by David on 17/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import Alamofire

struct Pagination {
    let page: Int = 1
    let limit: Int = 10
    
    var parameters : Parameters {
        return ["page" : page, "limit" : limit]
    }
}
