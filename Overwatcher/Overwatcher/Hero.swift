//
//  Hero.swift
//  Overwatcher
//
//  Created by Fhict on 02/11/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import Foundation

class Hero {
    
    var name = ""
    var eliminations = ""
    var damageDone = ""
    var healingDone = ""
    var timePlayed = ""
    var winPercentage = ""
    var gamesWon = ""
    var gamesPlayed = ""
    var meleeKills = ""
    var damageBlocked = ""
    
    
    init(name:String, eliminations:String, damageDone:String, healingDone:String, timePlayed:String, winPercentage:String, gamesWon:String, gamesPlayed:String, meleeKills:String, damageBlocked:String){
        self.name = name
        self.eliminations = eliminations
        self.damageDone = damageDone
        self.healingDone = healingDone
        self.timePlayed = timePlayed
        self.winPercentage = winPercentage
        self.gamesWon = gamesWon
        self.gamesPlayed = gamesPlayed
        self.meleeKills = meleeKills
        self.damageBlocked = damageBlocked
    }
    
    init(){
        
    }
    
}
