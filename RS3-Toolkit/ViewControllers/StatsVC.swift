//
//  StatsVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class StatsVC: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var statsTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var profileImage: UIImageView!
    // Labels
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var xpLabel: UILabel!
    @IBOutlet var skillLabel: UILabel!
    @IBOutlet var combatLabel: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var interstitial: GADInterstitial!
    
    let activityIndicator = UIActivityIndicatorView()
    var updating: Bool = false {
        didSet {
            if updating {
                startLoading()
            } else {
                stopLoading()
                updateViewData()
            }
        }
    }
    
    var store = UserDataStore()
    static var user: UserData = UserData() {
        didSet {
            Global.cachedUserData = StatsVC.user
        }
    }
    var localUser: UserData {
        return StatsVC.user
    }
    
    let tableViewDataSource = StatsTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-4468715439448322/3008848820")
        //interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") // Test ID
        
        if !Global.adShown {
            let request = GADRequest()
            interstitial.load(request)
        }
        
        statsTableView.dataSource = tableViewDataSource
        statsTableView.delegate = self
        searchBar.delegate = self
        tapGesture.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Global.cachedUserData != nil {
            LogVC.user = Global.cachedUserData!
            updateViewData()
        } else {
            updateUserData()
            updating = true
        }
        
        if Global.cachedUserAvatar != nil {
            profileImage.image = Global.cachedUserAvatar!
        } else {
            updateUserAvatar()
        }
    }
    
    func updateUserData() {
        store.fetchUserData() {
            (result) in
            
            switch result {
            case let .success(userData):
                StatsVC.user = userData
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
    
    func updateUserAvatar() {
        store.fetchUserAvatar() {
            (result) in
            
            switch result {
            case let .success(avatar):
                self.profileImage.image = avatar
                Global.cachedUserAvatar = avatar
            case .failure:
                print("Failed to Fetch User Avatar")
            }
        }
    }
    
    func updateViewData() {
        tableViewDataSource.userData = localUser
        statsTableView.reloadData()
        
        print("Attack Level: \(localUser.getSkill(id: 0)["level"]!)")
        usernameLabel.text = localUser.name
        
        //xpLabel.text = "Total XP: \(localUser.totalxp.convertToString())"
        let totalXPText = NSMutableAttributedString()
        totalXPText.bold("Total XP: ")
        totalXPText.normal("\(localUser.totalxp.convertToString())")
        xpLabel.attributedText = totalXPText
        
        //skillLabel.text = "Total Level: \(localUser.totalskill)"
        let totalLevelText = NSMutableAttributedString()
        totalLevelText.bold("Total Level: ")
        totalLevelText.normal("\(localUser.totalskill)")
        skillLabel.attributedText = totalLevelText
        
        //combatLabel.text = "Rank: \(localUser.rank)"
        let rankText = NSMutableAttributedString()
        rankText.bold("Rank: ")
        rankText.normal("\(localUser.rank)")
        combatLabel.attributedText = rankText
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Clicked!")
        Global.username = (searchBar.text?.replacingOccurrences(of: " ", with: "_")) ?? Global.username
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tapGesture.isEnabled = false
        updateUserData()
        updateUserAvatar()
        updating = true
        if interstitial.isReady && !Global.adShown {
            self.interstitial.present(fromRootViewController: self)
            Global.adShown = true
        } else {
            print("Ad wasn't ready or has already been shown")
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
        tapGesture.isEnabled = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tapGesture.isEnabled = true
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let skillID  = indexPath.row
        let skill = localUser.getSkill(id: skillID)
        var level = skill["level"]!
        var xp = String(skill["xp"]!).dropLast()
        if xp == "" { xp = "0" }
        let xpInt = Int(xp)!
        let formattedXP = xpInt.convertToString()
        let xpToLevel: String
        
        if level == 99 || level == 120 {
            // Level is likely higher than 99 and needs to be calculated
            if skillID == 26 {
                level = LevelTables.getEliteLevelForXP(xpInt)
            } else if skillID != 18 && skillID != 24 {
                level = LevelTables.getLevelForXP(xpInt)
            }
        }
        
        if skillID == 26 {
            xpToLevel = (LevelTables.getXPForEliteLevel(level + 1) - xpInt).convertToString() // Get Invetion XP
        } else {
            xpToLevel = (LevelTables.getXPForLevel(level + 1) - xpInt).convertToString()
        }
        
        var levelString = String(level)
        
        if level > 99 {
            if skillID != 18 && skillID != 24 {
                levelString = "\(skill["level"]!)" + "(\(levelString))"
            }
        }
        
        let skillInfo = "Level: \(levelString)\nXP: \(formattedXP)\nXP To Level Up: \(xpToLevel)"
        
        let ac = UIAlertController(title: "\(Global.getSkillString(id: indexPath.row))", message: skillInfo, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        ac.addAction(closeAction)
        self.present(ac, animated: true, completion: nil)
    }
    
}
