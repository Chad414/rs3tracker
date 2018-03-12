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
    
    func updateCell() {
        contentView.addSubview(iconView)
        contentView.addSubview(logLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
