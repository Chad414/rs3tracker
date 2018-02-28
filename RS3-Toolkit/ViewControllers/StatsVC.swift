//
//  StatsVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class StatsVC: UIViewController, UITableViewDelegate {
    @IBOutlet var statsTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var profileImage: UIImageView!
    // Labels
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var xpLabel: UILabel!
    @IBOutlet var skillLabel: UILabel!
    @IBOutlet var combatLabel: UILabel!
    
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
    
    let tableViewDataSource = StatsTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //statsTableView.dataSource = tableViewDataSource
        //statsTableView.delegate = self
        
        updateUserData()
        updating = true
        
        print("Stored User: \(StatsVC.user.name)")
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
            }
        }
    }
    
    func updateViewData() {
        usernameLabel.text = localUser.name
        xpLabel.text = "Total XP: \(localUser.totalxp.convertToString())"
        skillLabel.text = "Total Level: \(localUser.totalskill)"
        combatLabel.text = "Combat Level: \(localUser.combatlevel)"
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
    }
}

class StatCell: UITableViewCell {
    
    func updateSkill(skill: Int, exp: Int) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
