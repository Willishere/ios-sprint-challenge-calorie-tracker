//
//  CalorieTableViewCell.swift
//  Calorie Tracker
//
//  Created by William Chen on 10/18/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

class CalorieTableViewCell: UITableViewCell {
    @IBOutlet weak var calorieText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
