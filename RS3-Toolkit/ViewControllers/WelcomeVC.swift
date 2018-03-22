//
//  WelcomeVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/22/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var usernameTextInput: UITextField!
    
    var username: String {
        let username = usernameTextInput.text ?? ""
        return username.replacingOccurrences(of: " ", with: "_")
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        UserDefaults.standard.set(username, forKey: "username")
        Global.cachedUserData = nil
        Global.cachedUserAvatar = nil
        Global.username = username
        
        performSegue(withIdentifier: "continue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextInput.delegate = self
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        usernameTextInput.resignFirstResponder()
    }
    
}
