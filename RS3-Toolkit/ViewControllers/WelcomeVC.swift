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
    
    let activityIndicator = UIActivityIndicatorView()
    var updating: Bool = false {
        didSet {
            if updating {
                startLoading()
            } else {
                stopLoading()
            }
        }
    }
    
    var store = UserDataStore()
    
    var userDataFound: Bool = false {
        didSet {
            if userDataFound {
                Global.cachedUserData = nil
                Global.cachedUserAvatar = nil
                UserDefaults.standard.set(username, forKey: "username")
                performSegue(withIdentifier: "continue", sender: self)
            }
        }
    }
    
    func updateUserData() {
        store.fetchUserData() {
            (result) in
            
            switch result {
            case .success:
                self.userDataFound = true
                self.updating = false
            case .failure:
                print("Failed to Fetch User Data")
                self.updating = false
                // Show Alert Here
                let errorMessage = "The user either doesn't exist, has been offline for a while, or has privacy enabled."
                let ac = UIAlertController(title: "User Not Found", message: errorMessage, preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                ac.addAction(closeAction)
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    var username: String {
        let username = usernameTextInput.text ?? ""
        return username.replacingOccurrences(of: " ", with: "_")
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        updating = true
        Global.username = username
        updateUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextInput.delegate = self
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        usernameTextInput.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextInput.resignFirstResponder()
        return true
    }
    
    func startLoading() {
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        view.addSubview(activityIndicator);
        
        activityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
