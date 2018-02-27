//
//  StatsVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {
    @IBOutlet var statsTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var user: UserData?
    
    let tableViewDataSource = StatsTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //statsTableView.dataSource = tableViewDataSource
        
        let userDataStore = UserDataStore()
        
        userDataStore.fetchUserData() {
            (result) in
            
            switch result {
            case let .success(userData):
                self.user = userData
            case .failure:
                print("Failed to Fetch User Data")
            }
        }
        
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
