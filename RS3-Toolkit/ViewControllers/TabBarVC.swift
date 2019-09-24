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
        
        //self.isModalInPresentation = true
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = nil
        
        self.tabBar.barStyle = UIBarStyle.default
        self.tabBar.unselectedItemTintColor = nil
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        self.title = "Loading..."
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
}
