//
//  CalorieTableViewCell.swift
//  Calorie Tracker
//
//  Created by William Chen on 10/18/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    return formatter
}()

class CalorieTableViewCell: UITableViewCell {
    @IBOutlet private weak var calorieText: UILabel!
    @IBOutlet private weak var dateText: UILabel!
    
    var tracker: Tracker?{
        didSet{
            updateViews()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
       updateViews()
    }
    

    
    func updateViews(){
        guard let tracker = tracker  else {return}
        calorieText.text = String(tracker.calories)
        guard let date = tracker.date else {return}
        dateText.text = dateFormatter.string(from: date)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
