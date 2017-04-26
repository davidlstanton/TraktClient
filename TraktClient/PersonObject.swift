//
//  PersonObject.swift
//  TraktClient
//
//  Created by David on 26/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Foundation

final class PersonObject: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible  {
    let ids: StandardMediaObjectIds
    let name: String
    let biography: String?
    let birthday: Date?
    let death: Date?
    let birthPlace: String?
    let homePlace: String?
    
    init(name: String,
         ids: StandardMediaObjectIds,
         biography: String?,
         birthday: Date?,
         death: Date?,
         birthPlace: String?,
         homePlace: String?
        ) {
        self.name = name
        self.ids = ids
        self.biography = biography
        self.birthday = birthday
        self.death = death
        self.birthPlace = birthPlace
        self.homePlace = homePlace
    }
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let rep = representation as? [String : Any],
            let ids = StandardMediaObjectIds(response: response, representation: rep["ids"] as Any),
            let name = rep["name"] as? String
        else { return nil }
        
        self.ids = ids
        self.name = name
        
        self.biography = rep["biography"] as? String
        self.birthday = nil
        self.death = nil
        self.birthPlace = rep["birthplace"] as? String
        self.homePlace = rep["homeplace"] as? String

    }
    
    var description: String {
        var descriptionComponents: [String] = ["name: " + name]
        descriptionComponents.append("ids: \(ids.description)")
        if let biography = self.biography {
            descriptionComponents.append("biography: \(biography)")
        }
        if let birthday = self.birthday {
            descriptionComponents.append("birthday: \(birthday)")
        }
        if let death = self.death {
            descriptionComponents.append("death: \(death)")
        }
        if let birthPlace = self.birthPlace {
            descriptionComponents.append("birthPlace: \(birthPlace)")
        }
        if let homePlace = self.homePlace {
            descriptionComponents.append("homePlace: \(homePlace)")
        }
        return descriptionComponents.flatMap({$0}).joined(separator: "\n")
    }
    
}
