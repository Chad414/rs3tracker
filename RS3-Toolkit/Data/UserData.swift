//
//  UserData.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation

class UserData: Codable {
    
    var magic: Int
    var questsstarted: Int
    var totalskill: Int
    var questscomplete: Int
    var questsnotstarted: Int
    var totalxp: Int
    var ranged: Int
    var activities: [[String:String]]?
    var skillvalues: [[String:Int]]?
    var name: String
    var rank: String
    var melee: Int
    var combatlevel: Int
    var loggedIn: String
    
    init() {
        self.magic = -1
        self.questsstarted = -1
        self.totalskill = -1
        self.questscomplete = -1
        self.questsnotstarted = -1
        self.totalxp = -1
        self.ranged = -1
        self.activities = nil
        self.skillvalues = nil
        self.name = "null"
        self.rank = "null"
        self.melee = -1
        self.combatlevel = -1
        self.loggedIn = "null"
    }
    
}
