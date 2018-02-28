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
        
        cell.skillLabel.text = "\(Global.getSkillString(id: indexPath.row)) - \(userData.getSkill(id: indexPath.row)["level"]!)"
        cell.skillIcon.image = UIImage(named: "Skill\(indexPath.row).png")
        
        cell.updateCell()
        
        return cell
    }
    
}
