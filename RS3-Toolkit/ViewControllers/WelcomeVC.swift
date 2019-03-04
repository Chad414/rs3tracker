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
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var welcomeToLabel: UILabel!
    @IBOutlet var appTitleLabel: UILabel!
    @IBOutlet var instructionsLabel: UILabel!
    @IBOutlet var themeLabel: UILabel!
    @IBOutlet var themeSegmentedControl: UISegmentedControl!
    
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
    static var hideCancelButton = Global.firstTimeLaunchingApp
    
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
                //let errorMessage = "The user either doesn't exist, has been offline for a while, or has privacy enabled."
                if Global.darkMode {
                    let errorMessage = "Please make sure your RuneMetrics profile is set to public."
                    let ac = DarkAlertController(title: "User Not Found", message: errorMessage, preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    ac.addAction(closeAction)
                    self.present(ac, animated: true, completion: nil)
                } else {
                    let errorMessage = "Please make sure your RuneMetrics profile is set to public."
                    let ac = UIAlertController(title: "User Not Found", message: errorMessage, preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    ac.addAction(closeAction)
                    self.present(ac, animated: true, completion: nil)
                }
            }
        }
    }
    
    var username: String {
        let username = usernameTextInput.text ?? ""
        return username.replacingOccurrences(of: " ", with: "_")
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        if usernameTextInput.text == "" {
            let errorMessage = "Please enter your Runescape username."
            let ac = UIAlertController(title: "Not so fast!", message: errorMessage, preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            ac.addAction(closeAction)
            self.present(ac, animated: true, completion: nil)
        } else if usernameTextInput.text?.containsOnlyLetters() == false {
            print("Invalid username")
            usernameTextInput.text = ""
            usernameTextInput.resignFirstResponder()
            
            if Global.darkMode {
                let errorMessage = "Please enter a valid username."
                let ac = DarkAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                ac.addAction(closeAction)
                self.present(ac, animated: true, completion: nil)
            } else {
                let errorMessage = "Please enter a valid username."
                let ac = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                ac.addAction(closeAction)
                self.present(ac, animated: true, completion: nil)
            }
        } else {
            updating = true
            Global.username = username
            updateUserData()
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func themeSegmentedAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            Global.darkMode = false
            UserDefaults.standard.set(false, forKey: "darkmode")
            changeTheme()
        } else if sender.selectedSegmentIndex == 1 {
            Global.darkMode = true
            UserDefaults.standard.set(true, forKey: "darkmode")
            changeTheme()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeLabel.isHidden = true
        themeSegmentedControl.isHidden = true
        
        changeTheme()
        
        usernameTextInput.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 228/255, alpha: 1.0)
        
        usernameTextInput.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            welcomeToLabel.font = welcomeToLabel.font.withSize(CGFloat(36.0))
            appTitleLabel.font = appTitleLabel.font.withSize(CGFloat(38.0))
            instructionsLabel.font = instructionsLabel.font.withSize(CGFloat(29.0))
        }
        
        if WelcomeVC.hideCancelButton {
            cancelButton.isHidden = true
            WelcomeVC.hideCancelButton = false
            
            // Show theme selection on first launch
            themeLabel.isHidden = false
            themeSegmentedControl.isHidden = false
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if Global.darkMode {
            return .lightContent
        } else { return .default }
    }
    
    func changeTheme() {
        if Global.darkMode {
            self.view.backgroundColor = UIColor.black
            
            welcomeToLabel.textColor = UIColor.white
            appTitleLabel.textColor = UIColor.white
            instructionsLabel.textColor = UIColor.white
            themeLabel.textColor = UIColor.white
        } else {
            self.view.backgroundColor = Global.backgroundColor
            
            welcomeToLabel.textColor = UIColor.black
            appTitleLabel.textColor = UIColor.black
            instructionsLabel.textColor = UIColor.black
            themeLabel.textColor = UIColor.black
        }
        
        setNeedsStatusBarAppearanceUpdate()
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
        activityIndicator.style = UIActivityIndicatorView.Style.gray;
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        view.addSubview(activityIndicator);
        
        activityIndicator.startAnimating();
        //UIApplication.shared.beginIgnoringInteractionEvents();
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
