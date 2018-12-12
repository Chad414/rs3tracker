//
//  StatusCell.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/28/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    @IBOutlet var skillIcon: UIImageView!
    @IBOutlet var skillLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var progressViewLength: NSLayoutConstraint!
    @IBOutlet var skillIconLength: NSLayoutConstraint!
    @IBOutlet var skillIconHeight: NSLayoutConstraint!
    @IBOutlet var trailingConst: NSLayoutConstraint!
    
    func updateCell() {
        contentView.addSubview(skillIcon)
        contentView.addSubview(skillLabel)
        contentView.addSubview(progressView)
        
        if Global.darkMode {
            backgroundColor = UIColor.black
            self.contentView.backgroundColor = Global.darkBackgroundColor
            
            skillLabel.textColor = UIColor.white
            
            self.selectionStyle = .gray
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.0)
            self.selectedBackgroundView = bgColorView
        } else {
            backgroundColor = Global.backgroundColor
            self.contentView.backgroundColor = Global.backgroundColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class HeaderCell: UITableViewCell {
    
    @IBOutlet var totalLevelLabel: UILabel!
    @IBOutlet var totalXPLabel: UILabel!
    @IBOutlet var profileIcon: UIImageView!
    
    @IBOutlet var profileIconWidth: NSLayoutConstraint!
    @IBOutlet var profileIconHeight: NSLayoutConstraint!
    
    func updateCell() {
        contentView.addSubview(totalLevelLabel)
        contentView.addSubview(totalXPLabel)
        contentView.addSubview(profileIcon)
        
        if Global.darkMode {
            backgroundColor = UIColor.black
            self.contentView.backgroundColor = Global.darkBackgroundColor
            
            totalLevelLabel.textColor = UIColor.white
            totalXPLabel.textColor = UIColor.white
            
            self.selectionStyle = .gray
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.0)
            self.selectedBackgroundView = bgColorView
        } else {
            backgroundColor = Global.backgroundColor
            self.contentView.backgroundColor = Global.backgroundColor
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            profileIconWidth.constant = 64
            profileIconHeight.constant = 64
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
