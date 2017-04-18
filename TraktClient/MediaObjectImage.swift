//
//  MediaObjectImage.swift
//  TraktClient
//
//  Created by David on 17/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

final class MediaObjectImage: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {

    let identifier: String
    let url: String
    let lang: String
    let likes: String
    
    init(identifier: String, url: String, lang: String, likes: String) {
        self.identifier = identifier
        self.url = url
        self.lang = lang
        self.likes = likes
    }
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let rep = representation as? [String : Any],
            let identifier = rep["id"] as? String,
            let url = rep["url"] as? String,
            let lang = rep["lang"] as? String,
            let likes = rep["likes"] as? String
            else { return nil }
        self.identifier = identifier
        self.url = url
        self.lang = lang
        self.likes = likes
    }
    
    var description: String {
        return "id: \(identifier)\n url: \(url)\n lang: \(lang)\n likes: \(likes)\n"
    }
}
