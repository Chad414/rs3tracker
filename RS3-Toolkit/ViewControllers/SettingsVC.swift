//
//  SettingsVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/22/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBAction func icons8Link(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://icons8.com")!)
    }
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}