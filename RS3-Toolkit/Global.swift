//
//  Global.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation
import UIKit

struct Global {
    static var storedUsername: String = "Dark_Poet"
    static var username: String = "ChadTek"
    static var activities: Int = 20
    static var updateInProgress: Bool = false {
        didSet {
            if updateInProgress {
                print("--Loading Data--")
            } else {
                print("--Finished Loading Data--")
            }
        }
    }
    static var cachedUserData: UserData?
    static var cachedUserAvatar: UIImage?
    
    static func getSkillString(id: Int) -> String {
        switch id {
        case 0:
            return "Attack"
        case 1:
            return "Defence"
        case 2:
            return "Strength"
        case 3:
            return "Constitution"
        case 4:
            return "Ranged"
        case 5:
            return "Prayer"
        case 6:
            return "Magic"
        case 7:
            return "Cooking"
        case 8:
            return "Woodcutting"
        case 9:
            return "Fletching"
        case 10:
            return "Fishing"
        case 11:
            return "Firemaking"
        case 12:
            return "Crafting"
        case 13:
            return "Smithing"
        case 14:
            return "Mining"
        case 15:
            return "Herblore"
        case 16:
            return "Agility"
        case 17:
            return "Thieving"
        case 18:
            return "Slayer"
        case 19:
            return "Farming"
        case 20:
            return "Runecrafting"
        case 21:
            return "Hunter"
        case 22:
            return "Construction"
        case 23:
            return "Summoning"
        case 24:
            return "Dungeoneering"
        case 25:
            return "Divination"
        case 26:
            return "Invention"
        default:
            return "Skill Not Found"
        }
    }
}

extension Int {
    func convertToString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont.boldSystemFont(ofSize: 19.0)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 17.0)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
}

/* Skill ID's
 
 0 - Attack
 1 - Defence
 2 - Strength
 3 - Constitution
 4 - Ranged
 5 - Prayer
 6 - Magic
 7 - Cooking
 8 - Woodcutting
 9 - Fletching
 10 - Fishing
 11 - Firemaking
 12 - Crafting
 13 - Smithing
 14 - Mining
 15 - Herblore
 16 - Agility
 17 - Thieving
 18 - Slayer
 19 - Farming
 20 - Runecrafting
 21 - Hunter
 22 - Construction
 23 - Summoning
 24 - Dungeoneering
 25 - Divination
 26 - Invention
 */

