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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
