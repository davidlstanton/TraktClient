//
//  Pagination.swift
//  TraktClient
//
//  Created by David on 17/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

struct Pagination {
    let page: Int
    let limit: Int
    
    func urlParameters() -> [String: Int] {
        return ["page" : page, "limit" : limit]
    }
}
