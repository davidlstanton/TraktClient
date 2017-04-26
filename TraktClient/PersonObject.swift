//
//  PersonObject.swift
//  TraktClient
//
//  Created by David on 26/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class PersonObject: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible  {
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
        self.death = death
        self.birthPlace = birthPlace
        self.homePlace = homePlace
    }
    
    
    
}
