//
//  LogTableViewDataSource.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/8/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class LogTableViewDataSource: NSObject, UITableViewDataSource {
    
    var userData: UserData!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard userData != nil else {
            return 20
        }
        
        return userData.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! LogCell
        
        guard userData != nil else {
            return cell
        }
        
        let activity = userData.activities[indexPath.row]
        
        let logText = activity["text"]!
        
        if logText.range(of: "Levelled") != nil || logText.range(of: "levels") != nil || logText.range(of: "XP") != nil {
            cell.iconView.image = UIImage(named: "icons8-positive_dynamic_filled.png")
        } else if logText.range(of: "Quest") != nil {
            cell.iconView.image = UIImage(named: "icons8-compass_filled.png")
        } else if logText.range(of: "Clan") != nil {
            cell.iconView.image = UIImage(named: "icons8-castle_filled.png")
        } else if logText.range(of: "found")  != nil {
            cell.iconView.image = UIImage(named: "icons8-coins_filled.png")
        } else if logText.range(of: "killed") != nil {
            cell.iconView.image = UIImage(named: "icons8-dragon_filled.png")
        } else if logText.range(of: "trail") != nil {
            cell.iconView.image = UIImage(named: "icons8-adventure_filled.png")
        } else if logText.range(of: "floor") != nil {
            cell.iconView.image = UIImage(named: "icons8-adventure_filled.png")
        } else {
            cell.iconView.image = UIImage(named: "icons8-checklist_filled.png")
        }
        
        cell.logLabel.text = logText
        
        cell.backgroundColor = Global.backgroundColor
        
        cell.updateCell()
        
        return cell
    }
    
}
