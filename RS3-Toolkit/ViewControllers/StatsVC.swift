//
//  StatsVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class StatsVC: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var statsTableView: UITableView!

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
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
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .fullScreen
        
        statsTableView.dataSource = tableViewDataSource
        statsTableView.delegate = self
        tapGesture.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = Global.backgroundColor
        statsTableView.backgroundColor = Global.backgroundColor
        statsTableView.separatorColor = Global.backgroundColor
    
        
        self.tabBarController?.navigationItem.searchController?.searchBar.delegate = self
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        if Global.cachedUserData == nil || Global.username.replacingOccurrences(of: "_", with: " ") != localUser.name {
            updateUserData()
            updateUserAvatar()
            updating = true
        } else {
            updateViewData()
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
                if Global.username == Global.storedUsername {
                    WelcomeVC.hideCancelButton = true
                    let errorMessage = "User is no longer available. Please make sure your RuneMetrics profile is set to public."
                    let ac = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: { (sender: UIAlertAction) in
                        self.performSegue(withIdentifier: "welcome", sender: self)
                    })
                    ac.addAction(closeAction)
                    self.present(ac, animated: true, completion: nil)
                } else {
                    let errorMessage = "The user either doesn't exist, has been offline for a while, or has privacy enabled."
                    let ac = UIAlertController(title: "User Not Found", message: errorMessage, preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    ac.addAction(closeAction)
                    self.present(ac, animated: true, completion: nil)
                }
            }
        }
    }
    
    func updateUserAvatar() {
        store.fetchUserAvatar() {
            (result) in
            
            switch result {
            case let .success(avatar):
                //self.profileImage.image = avatar
                //Global.cachedUserAvatar = UIImage(named: "chadtek.png")
                Global.cachedUserAvatar = avatar
                self.statsTableView.reloadData()
            case .failure:
                print("Failed to Fetch User Avatar")
            }
        }
    }
    
    func updateViewData() {
        tableViewDataSource.userData = localUser
        statsTableView.reloadData()
        
        print("Attack Level: \(localUser.getSkill(id: 0)["level"]!)")
        //usernameLabel.text = localUser.name
        //self.navigationController?.topViewController?.title = localUser.name
        self.tabBarController?.title = localUser.name
        
        //xpLabel.text = "Total XP: \(localUser.totalxp.convertToString())"
        let totalXPText = NSMutableAttributedString()
        totalXPText.bold("Total XP: ")
        totalXPText.normal("\(localUser.totalxp.convertToString())")
        //xpLabel.attributedText = totalXPText
        
        //skillLabel.text = "Total Level: \(localUser.totalskill)"
        let totalLevelText = NSMutableAttributedString()
        totalLevelText.bold("Total Level: ")
        totalLevelText.normal("\(localUser.totalskill)")
        //skillLabel.attributedText = totalLevelText
        
        //combatLabel.text = "Rank: \(localUser.rank)"
        let rankText = NSMutableAttributedString()
        rankText.bold("Rank: ")
        rankText.normal("\(localUser.rank)")
        if UIDevice.current.userInterfaceIdiom == .pad {
            //rankiPadLabel.attributedText = rankText
        } else {
            //combatLabel.attributedText = rankText
        }
    }
    
    func startLoading() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()

        timer = Timer.scheduledTimer(timeInterval: 8, target: self,   selector: (#selector(failedToFetchData)), userInfo: nil, repeats: true)

    }
    
    @objc func failedToFetchData() {
        stopLoading()
        
        Global.cachedUserData = UserData()
        updateViewData()
        
        print("Error Fetching Data")
        
        let errorMessage = "Please check your internet connection."
        let ac = UIAlertController(title: "No response from server", message: errorMessage, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        ac.addAction(closeAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    func stopLoading() {
        timer.invalidate()
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Clicked!")
        let input = searchBar.text?.replacingOccurrences(of: " ", with: "_") ?? Global.username
        
        if searchBar.text == "" {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.tabBarController?.navigationItem.searchController?.isActive = false
            return
        }
        
        //if ((searchBar.text?.range(of: pattern, options: .regularExpression)) == nil) {
        if searchBar.text?.rangeOfCharacter(from: Global.usernameChar.inverted) != nil {
            print("Invalid username")
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.tabBarController?.navigationItem.searchController?.isActive = false
            
            let errorMessage = "Please enter a valid username."
            let ac = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            ac.addAction(closeAction)
            self.present(ac, animated: true, completion: nil)
            
            return
        }
        
        Global.username = input
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tabBarController?.navigationItem.searchController?.isActive = false
        tapGesture.isEnabled = false
        updateUserData()
        updateUserAvatar()
        updating = true
        
        //showAd()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.tabBarController?.navigationItem.searchController?.isActive = false
        tapGesture.isEnabled = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tapGesture.isEnabled = true
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let message = "Rank: \(localUser.rank) \n\n Quests Completed: \(localUser.questscomplete) \n Quests Started: \(localUser.questsstarted) \n Quests Not Started: \(localUser.questsnotstarted)"
            
            let ac = UIAlertController(title: "\(localUser.name)", message: message, preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            ac.addAction(closeAction)
            self.present(ac, animated: true, completion: nil)
        }
        
        let skillID  = indexPath.row - 1
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
        } else if skillID == 24 && level == 120 { // Max Dungeoneering
            xpToLevel = "0"
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
        
        let ac = UIAlertController(title: "\(Global.getSkillString(id: skillID))", message: skillInfo, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        ac.addAction(closeAction)
        self.present(ac, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if indexPath.row == 0 {
                return 95.0
            } else {
                return 70.0
            }
        } else {
            if indexPath.row == 0 {
                return 70.0
            } else {
                return 44.0
            }
        }
    }
}
