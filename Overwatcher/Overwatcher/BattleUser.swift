//
//  BattleUser.swift
//  Overwatcher
//
//  Created by Fhict on 14/10/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class BattleUser : Object {
    
    dynamic var battleTag = ""
    dynamic var username = ""
    dynamic var rating = 0
    dynamic var level = 0
    dynamic var quickWins = 0
    dynamic var compWins = 0
    dynamic var compLost = 0
    dynamic var totalPlayed = 0
    dynamic var quickTime = ""
    dynamic var compTime = ""
    dynamic var avatar = ""
    dynamic var rankImg = ""
    dynamic var role = "Tank"
    
    override static func primaryKey() -> String? {
        return "battleTag"
    }
}
