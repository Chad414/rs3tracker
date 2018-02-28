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
    
    func updateCell() {
        contentView.addSubview(skillIcon)
        contentView.addSubview(skillLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
