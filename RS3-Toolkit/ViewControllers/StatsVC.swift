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
    let activityIndicator = UIActivityIndicatorView()
    
    var user: UserData?
    
    let tableViewDataSource = StatsTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //statsTableView.dataSource = tableViewDataSource
        //statsTableView.delegate = self
        
        startLoading()
        
        print("Stored User: \(Global.mainUserData.name)")
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
