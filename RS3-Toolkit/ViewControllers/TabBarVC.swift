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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        self.title = "Loading..."
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        if Global.darkMode {
            self.navigationController?.navigationBar.barStyle = UIBarStyle.black
            self.navigationController?.navigationBar.tintColor = UIColor.white
            
            self.tabBar.barStyle = UIBarStyle.black
            self.tabBar.unselectedItemTintColor = UIColor.white
            
            self.view.backgroundColor = UIColor.black
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}
