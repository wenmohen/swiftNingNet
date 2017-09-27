//
//  CommonCell.swift
//  swiftNetTry
//
//  Created by nhl on 2017/9/26.
//  Copyright © 2017年 nhl. All rights reserved.
//

import UIKit

class CommonCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
