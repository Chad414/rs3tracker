//
//  PlayerData.swift
//  RS3TrackerWidgetExtension
//
//  Created by Chad Hamdan on 11/7/22.
//  Copyright © 2022 Chad Hamdan. All rights reserved.
//

import Foundation

// MARK: - PlayerData
struct PlayerData: Codable {
    let magic, questsstarted, totalskill, questscomplete: Int?
    let questsnotstarted, totalxp, ranged: Int?
    let activities: [Activity]?
    let skillvalues: [Skillvalue]?
    let name, rank: String?
    let melee, combatlevel: Int?
    let loggedIn: String?

    // MARK: - Activity
    struct Activity: Codable {
        let date, details, text: String?
    }

    // MARK: - Skillvalue
    struct Skillvalue: Codable {
        let level, xp, rank, id: Int?
    }
}
