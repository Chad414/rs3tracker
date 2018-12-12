//
//  LogCell.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/8/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {
    
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var logLabel: UILabel!
    
    @IBOutlet var iconLength: NSLayoutConstraint!
    @IBOutlet var iconHeight: NSLayoutConstraint!
    @IBOutlet var trailingConst: NSLayoutConstraint!
    
    func updateCell() {
        contentView.addSubview(iconView)
        contentView.addSubview(logLabel)
        
        if Global.darkMode {
            backgroundColor = UIColor.black
            self.contentView.backgroundColor = Global.darkBackgroundColor
            
            logLabel.textColor = UIColor.white
            
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
