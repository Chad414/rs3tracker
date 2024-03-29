//
//  LogVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/8/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class LogVC: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var logTableView: UITableView!
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
    
    let tableViewDataSource = LogTableViewDataSource()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            logTableView.rowHeight = 70.0
        } else {
            logTableView.rowHeight = 50.0
        }
        
        logTableView.dataSource = tableViewDataSource
        logTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = Global.backgroundColor
        logTableView.backgroundColor = Global.backgroundColor
        
        self.view.backgroundColor = Global.backgroundColor
        logTableView.backgroundColor = Global.backgroundColor
        logTableView.separatorColor = Global.backgroundColor
        
        
        self.tabBarController?.navigationItem.searchController?.searchBar.delegate = self
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        
        if Global.cachedUserData != nil {
            LogVC.user = Global.cachedUserData!
            updateViewData()
        } else {
            updateUserData()
            updating = true
        }
        
        if Global.cachedUserAvatar != nil {
            //profileImage.image = Global.cachedUserAvatar!
        } else {
            updateUserAvatar()
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
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
                //self.profileImage.image = avatar
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
        
        self.tabBarController?.title = localUser.name
        
        /*let questProgressText = NSMutableAttributedString()
        questProgressText.bold("Quest Progress")
        questProgressLabel.attributedText = questProgressText
        
        questsCompleteLabel.text = "\(localUser.questscomplete)"
        questsStartedLabel.text = "\(localUser.questsstarted)"
        questsNotStartedLabel.text = "\(localUser.questsnotstarted)"*/
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
        //profileImage.image = UIImage(named: "chadtek.png")
        updateViewData()
        
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
