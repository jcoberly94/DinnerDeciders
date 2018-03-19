//
//  ReviewCell.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/11/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    static let reuseIdentifier = "ReviewCell"
    

    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
