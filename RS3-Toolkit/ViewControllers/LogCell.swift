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
        

        backgroundColor = Global.backgroundColor
        self.contentView.backgroundColor = Global.backgroundColor
        
        logLabel.textColor = UIColor.black
        
        self.selectionStyle = .default
        self.selectedBackgroundView = nil
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
