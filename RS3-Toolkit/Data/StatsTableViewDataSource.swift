//
//  StatsTableViewDataSource.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class StatsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var userData: UserData!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard userData != nil else {
            return 20
        }
        
        return userData.skillvalues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as! StatusCell
        
        guard userData != nil else {
            return cell
        }
        let skillID = indexPath.row
        let skill = userData.getSkill(id: skillID)
        
        var xp = String(skill["xp"]!).dropLast()
        if xp == "" { xp = "0" }
        let xpInt = Int(xp)!
        
        let level = skill["level"]!
        
        //print("Skill: \(skillID)")
        
        var xpTowardNextLevel: Float
        var xpDifference: Float
        
        if skillID == 26 {
            xpTowardNextLevel = Float(xpInt - LevelTables.getXPForEliteLevel(level))
            xpDifference = Float(LevelTables.getXPForEliteLevel(level + 1)) - Float(LevelTables.getXPForEliteLevel(level))
        } else {
            xpTowardNextLevel = Float(xpInt - LevelTables.getXPForLevel(level))
            xpDifference = Float(LevelTables.getXPForLevel(level + 1)) - Float(LevelTables.getXPForLevel(level))
        }
        //print("xpToward Next Level \(xpTowardNextLevel)")
        //print("xpDifference: \(xpDifference)")
        
        let progress: Float
        
        if level == 99 || level == 120 {
            progress = 1.0
        } else {
            progress = xpTowardNextLevel / xpDifference
        }
        
        //print("Progress: \(progress)")
        
        let skillText = NSMutableAttributedString()
        skillText.bold("\(Global.getSkillString(id: skillID)): ")
        skillText.normal("\(level)")
        cell.skillLabel.attributedText = skillText

        cell.skillIcon.image = UIImage(named: "Skill\(skillID).png")
        cell.progressView.progress = progress
        
        cell.updateCell()
        
        return cell
    }
    
}
