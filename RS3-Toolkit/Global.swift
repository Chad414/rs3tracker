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
    static var firstTimeLaunchingApp: Bool = false
    static var storedUsername: String = UserDefaults.standard.string(forKey: "username") ?? "ChadTek"
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
    static var adShown: Bool = false
    static let usernameChar = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_")
    //static var darkMode: Bool = UserDefaults.standard.bool(forKey: "darkmode")
    
    static let systemVersion = UIDevice.current.systemVersion
    static let backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    //static let backgroundColor = UIColor.white
    
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
    
    static func displayIsCompact() -> Bool {
        if UIScreen.main.nativeBounds.height <= 1136 {
            return true
        } else {
            return false
        }
    }
    
    static func deviceIs97InchiPad() -> Bool {
        if UIScreen.main.nativeBounds.height <= 2048 && UIDevice.current.userInterfaceIdiom == .pad {
            return true
        } else {
            return false
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

extension String {
    func takeSubstring(start: Int, end: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: start)
        let end = self.index(self.endIndex, offsetBy: end)
        let range = start..<end
        
        let substring = self[range]
        
        return String(substring)
    }
    
    func containsOnlyLetters() -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        if self.rangeOfCharacter(from: characterset.inverted) != nil {
            return false
        }
        return true
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        var size: CGFloat = 19.0
        
        if Global.displayIsCompact() {
            if text == "Dungeoneering: " {
                size = 14.0
            } else {
                size = 17.0
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            size = 26.0
        }
        
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: size)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func headerbold(_ text: String) -> NSMutableAttributedString {
        var size: CGFloat = 20.0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            size = 28.0
        }
        
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: size)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func header(_ text: String) -> NSMutableAttributedString {
        var size: CGFloat = 20.0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            size = 28.0
        }
        
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size)]
        let string = NSMutableAttributedString(string:text, attributes: attrs)
        append(string)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        var size: CGFloat = 17.0
        
        if Global.displayIsCompact() {
            if text.count >= 11 {
                size = 13.0
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            size = 24.0
        }
        
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
}

func firstTimeLaunchingApp() -> Bool {
    if let _ = UserDefaults.standard.string(forKey: "firstTimeLaunchingApp"){
        return false
    } else {
        UserDefaults.standard.set(true, forKey: "firstTimeLaunchingApp")
        return true
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
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

