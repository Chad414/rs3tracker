//
//  TabVarVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 11/29/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        if Global.darkMode {
            self.navigationController?.navigationBar.barStyle = UIBarStyle.black
            self.navigationController?.navigationBar.tintColor = UIColor.white
            
            self.tabBar.barStyle = UIBarStyle.black
            self.tabBar.unselectedItemTintColor = UIColor.white
            
            self.view.backgroundColor = UIColor.black
        } else {
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.tintColor = nil
            
            self.tabBar.barStyle = UIBarStyle.default
            self.tabBar.unselectedItemTintColor = nil
        }
        
        self.title = "Loading..."
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
}
