//
//  UserData.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation

class UserData: Codable {
    
    let magic: Int
    let questsstarted: Int
    let totalskill: Int // Stats
    let questscomplete: Int // Log
    let questsnotstarted: Int
    let totalxp: Int // Stats
    let ranged: Int
    let activities: [[String:String]] // Log
    let skillvalues: [[String:Int]] // Stats
    let name: String
    let rank: String // Stats
    let melee: Int
    let combatlevel: Int // Combat Level
    let loggedIn: String
    
    init() {
        self.magic = -1
        self.questsstarted = -1
        self.totalskill = -1
        self.questscomplete = -1
        self.questsnotstarted = -1
        self.totalxp = -1
        self.ranged = -1
        self.activities = []
        self.skillvalues = []
        self.name = "null"
        self.rank = "null"
        self.melee = -1
        self.combatlevel = -1
        self.loggedIn = "null"
    }
    
    func getSkill(id: Int) -> [String:Int] {
        for i in skillvalues {
            if i["id"] == id {
                return i
            }
        }
        print("Skill not found")
        return ["level" : -1, "xp" : -1, "rank" : -1, "id" : -1]
    }
    
}
