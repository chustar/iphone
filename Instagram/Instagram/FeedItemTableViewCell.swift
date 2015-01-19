//
//  FeedItemTableViewCell.swift
//  Instagram
//
//  Created by Chuma Nnaji on 1/18/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var username: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
