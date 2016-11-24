//
//  myTableViewCell.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/11/23.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    @IBOutlet weak var hideLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
