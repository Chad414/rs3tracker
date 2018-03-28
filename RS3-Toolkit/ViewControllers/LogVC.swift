//
//  LogVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/8/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LogVC: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var logTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var questProgressLabel: UILabel!
    @IBOutlet var questsCompleteLabel: UILabel!
    @IBOutlet var questsStartedLabel: UILabel!
    @IBOutlet var questsNotStartedLabel: UILabel!
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
            Global.cachedUserData = LogVC.user
        }
    }
    var localUser: UserData {
        return StatsVC.user
    }
    
    let tableViewDataSource = LogTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Global.backgroundColor
        logTableView.backgroundColor = Global.backgroundColor
        searchBar.searchBarStyle = .minimal
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-4468715439448322/3008848820")
        //interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") // Test ID
        
        if !Global.adShown {
            let request = GADRequest()
            interstitial.load(request)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            logTableView.rowHeight = 70.0
            usernameLabel.font = usernameLabel.font.withSize(28.0)
            questsCompleteLabel.font = questsCompleteLabel.font.withSize(CGFloat(20.0))
            questsStartedLabel.font = questsStartedLabel.font.withSize(CGFloat(20.0))
            questsNotStartedLabel.font = questsNotStartedLabel.font.withSize(CGFloat(20.0))
        } else {
            logTableView.rowHeight = 50.0
        }
        
        logTableView.dataSource = tableViewDataSource
        logTableView.delegate = self
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
                //self.profileImage.image = UIImage(named: "chadtek.png")
                Global.cachedUserAvatar = avatar
            case .failure:
                print("Failed to Fetch User Avatar")
            }
        }
    }
    
    func updateViewData() {
        tableViewDataSource.userData = localUser
        logTableView.reloadData()
        
        usernameLabel.text = localUser.name
        
        let questProgressText = NSMutableAttributedString()
        questProgressText.bold("Quest Progress")
        questProgressLabel.attributedText = questProgressText
        
        questsCompleteLabel.text = "\(localUser.questscomplete)"
        questsStartedLabel.text = "\(localUser.questsstarted)"
        questsNotStartedLabel.text = "\(localUser.questsnotstarted)"
    }
    
    func startLoading() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
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
        
        let activity = localUser.activities[indexPath.row]
        
        let rawDate = activity["date"]!
        let activityInfo = activity["details"]!
        
        let month = rawDate.takeSubstring(start: 3, end: -11)
        let day = rawDate.takeSubstring(start: 0, end: -15)
        let year = rawDate.takeSubstring(start: 7, end: -6)
        let time = rawDate.takeSubstring(start: 12, end: 0)
        
        let activityDate = "\(month) \(day), \(year) at \(time)"
        
        let ac = UIAlertController(title: activityDate, message: activityInfo, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        ac.addAction(closeAction)
        self.present(ac, animated: true, completion: nil)
    }
    
}
