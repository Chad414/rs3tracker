//
//  SettingsVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/22/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet var versionLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var settingsLabel: UILabel!
    @IBOutlet var changeUserButton: UIButton!
    @IBOutlet var creditsLabel: UILabel!
    @IBOutlet var developedByLabel: UILabel!
    @IBOutlet var chadHamdanLabel: UILabel!
    //@IBOutlet var appIconCreditLabel: UIButton!
    //@IBOutlet var appIconLabel: UILabel!
    @IBOutlet var uiIconLabel: UILabel!
    @IBOutlet var icons8Button: UIButton!
    @IBOutlet var rsnLabel: UILabel!
    @IBOutlet var themeLabel: UILabel!
    
    @IBOutlet var themeSegmentedControl: UISegmentedControl!
    
    @IBOutlet var profileImageWidth: NSLayoutConstraint!
    @IBOutlet var profileImageHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme()
        
        if Global.darkMode {
            themeSegmentedControl.selectedSegmentIndex = 1
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleLabel.font = titleLabel.font.withSize(CGFloat(38.0))
            versionLabel.font = versionLabel.font.withSize(CGFloat(29.0))
            settingsLabel.font = settingsLabel.font.withSize(CGFloat(32.0))
            changeUserButton.titleLabel?.font = changeUserButton.titleLabel?.font.withSize(CGFloat(27.0))
            creditsLabel.font = creditsLabel.font.withSize(CGFloat(32.0))
            developedByLabel.font = creditsLabel.font.withSize(CGFloat(26.0))
            chadHamdanLabel.font = chadHamdanLabel.font.withSize(CGFloat(30.0))
            //appIconCreditLabel.titleLabel?.font = appIconCreditLabel.titleLabel?.font.withSize(CGFloat(28.0))
            //appIconLabel.font = appIconLabel.font.withSize(CGFloat(26.0))
            uiIconLabel.font = uiIconLabel.font.withSize(CGFloat(26.0))
            icons8Button.titleLabel?.font = icons8Button.titleLabel?.font.withSize(CGFloat(28.0))
            rsnLabel.font = rsnLabel.font.withSize(CGFloat(22.0))
            
            profileImageWidth.constant = 200
            profileImageHeight.constant = 200
            
            updateLayoutFor97iPad()
        }
        
        versionLabel.text = "Version " + Bundle.main.releaseVersionNumber!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if Global.darkMode {
            return .lightContent
        } else { return .default }
    }
    
    func updateTheme() {
        if Global.darkMode {
            self.view.backgroundColor = UIColor.black
            
            titleLabel.textColor = UIColor.white
            versionLabel.textColor = UIColor.white
            settingsLabel.textColor = UIColor.white
            creditsLabel.textColor = UIColor.white
            developedByLabel.textColor = UIColor.white
            chadHamdanLabel.textColor = UIColor.white
            //appIconLabel.textColor = UIColor.white
            uiIconLabel.textColor = UIColor.white
            rsnLabel.textColor = UIColor.white
            themeLabel.textColor = UIColor.white
        } else {
            self.view.backgroundColor = Global.backgroundColor
            
            titleLabel.textColor = UIColor.black
            versionLabel.textColor = UIColor.black
            settingsLabel.textColor = UIColor.black
            creditsLabel.textColor = UIColor.black
            developedByLabel.textColor = UIColor.black
            chadHamdanLabel.textColor = UIColor.black
            //appIconLabel.textColor = UIColor.white
            uiIconLabel.textColor = UIColor.black
            rsnLabel.textColor = UIColor.black
            themeLabel.textColor = UIColor.black
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            updateLayoutFor97iPad()
        }
    }
    
    func updateLayoutFor97iPad() {
        if UIDevice.current.orientation != UIDeviceOrientation.portrait && UIDevice.current.orientation != UIDeviceOrientation.portraitUpsideDown {
            if Global.deviceIs97InchiPad() {
                guard profileImageHeight != nil && profileImageWidth != nil else { return }
                profileImageWidth.constant = 100
                profileImageHeight.constant = 100
            }
        } else {
            guard profileImageHeight != nil && profileImageWidth != nil else { return }
            profileImageWidth.constant = 200
            profileImageHeight.constant = 200
        }
    }
    
    let emailURL: URL! = URL(string: "mailto:feedback@chadhamdan.me")
    
    @IBAction func themeSegmentedAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            Global.darkMode = false
            UserDefaults.standard.set(false, forKey: "darkmode")
            updateTheme()
        } else if sender.selectedSegmentIndex == 1 {
            Global.darkMode = true
            UserDefaults.standard.set(true, forKey: "darkmode")
            updateTheme()
        }
    }
    
    @IBAction func icons8Link(_ sender: UIButton) {
        UIApplication.shared.open(emailURL)
    }
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*@IBAction func appIconLink(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/profile.php?id=100005939234711")!)
    }*/
}
