//
//  ExtendedInfo.swift
//  TraktClient
//
//  Created by David on 13/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import Alamofire

enum ExtendedInfo: String {
    case full = "full"
    case metadata = "metadata"
    
    func parameter() -> Parameters {
        return ["extended" : self.rawValue]
    }
}
