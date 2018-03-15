//
//  CombatVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/15/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class CombatVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var combatLevelLabel: UILabel!
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
            Global.cachedUserData = LogVC.user
        }
    }
    var localUser: UserData {
        return StatsVC.user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
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
        usernameLabel.text = localUser.name
        
        let combatLevelText = NSMutableAttributedString()
        combatLevelText.bold("Combat Level: ")
        combatLevelText.normal("\(localUser.combatlevel)")
        combatLevelLabel.attributedText = combatLevelText
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
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
        tapGesture.isEnabled = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tapGesture.isEnabled = true
        return true
    }
    
    func getCombatLevel(att: Int, str: Int, def: Int, range: Int, magic: Int, const: Int, pray: Int, summ: Int) -> Double {
        var max = 0
        
        if (att > str && att > range && att > magic) || (str > range && str > magic) {
            // Add strength and attack
            max = att + str
        } else if range > magic {
            // Double range
            max = range * 2
        } else {
            // Double magic
            max = magic * 2
        }
        
        let result: Double = (13/10) * Double(max) + Double(def) + Double(const) + Double(pray / 2) + Double(summ / 2)
        
        return result / 4
    }
}
