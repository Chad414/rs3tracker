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
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var questPointsLabel: UILabel!
    @IBOutlet var questsCompleteLabel: UILabel!
    @IBOutlet var questsStartedLabel: UILabel!
    @IBOutlet var questsNotStartedLabel: UILabel!
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
    static var user: UserData = UserData()
    var localUser: UserData {
        return StatsVC.user
    }
    
    let tableViewDataSource = LogTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logTableView.dataSource = tableViewDataSource
        logTableView.delegate = self
        searchBar.delegate = self
        
        // Check if data is already stored
        
        updateUserData()
        updating = true
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
        store.fetchUserAvatar() {
            (result) in
            
            switch result {
            case let .success(avatar):
                self.profileImage.image = avatar
            case .failure:
                print("Failed to Fetch User Avatar")
            }
        }
    }
    
    func updateViewData() {
        tableViewDataSource.userData = localUser
        logTableView.reloadData()
        
        usernameLabel.text = localUser.name
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
        searchBar.resignFirstResponder()
        tapGesture.isEnabled = false
        updateUserData()
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
    
    
}
