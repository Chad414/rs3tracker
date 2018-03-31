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
        self.magic = 1
        self.questsstarted = 0
        self.totalskill = 0
        self.questscomplete = 0
        self.questsnotstarted = 0
        self.totalxp = 0
        self.ranged = 1
        self.activities = []
        self.skillvalues = [
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 0],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 1],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 2],
        ["level" : 10, "xp" : 11540, "rank" : -1, "id" : 3],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 4],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 5],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 6],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 7],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 8],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 9],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 10],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 11],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 12],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 13],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 14],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 15],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 16],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 17],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 18],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 19],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 20],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 21],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 22],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 23],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 24],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 25],
        ["level" : 1, "xp" : 00, "rank" : -1, "id" : 26],
        ]
        self.name = "Offline"
        self.rank = "Offline"
        self.melee = 1
        self.combatlevel = 3
        self.loggedIn = "Offline"
    }
    
    func getSkill(id: Int) -> [String:Int] {
        for i in skillvalues {
            if i["id"] == id {
                return i
            }
        }
        print("Skill not found")
        return ["level" : -1, "xp" : 10, "rank" : -1, "id" : -1]
    }
    
}
