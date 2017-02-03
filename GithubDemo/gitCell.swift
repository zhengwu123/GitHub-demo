//
//  gitCell.swift
//  GithubDemo
//
//  Created by zheng wu on 1/31/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class gitCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var gitImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var forksCountLabel: UILabel!
    @IBOutlet var starsCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
