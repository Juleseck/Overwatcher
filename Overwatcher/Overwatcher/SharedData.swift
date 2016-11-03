//
//  DataSingleton.swift
//  Overwatcher
//
//  Created by Fhict on 20/10/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import Foundation
import RealmSwift

class SharedData{
    
    var battleUser = BattleUser()
    var foundPlayers = [BattleUser]()
    static var sharedInstance = SharedData()

}
