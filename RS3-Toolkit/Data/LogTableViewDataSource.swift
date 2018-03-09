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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! LogCell
        
        return cell
    }
    
}
