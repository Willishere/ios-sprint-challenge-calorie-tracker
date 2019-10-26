//
//  Controller.swift
//  Calorie Tracker
//
//  Created by William Chen on 10/18/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation

class TrackerController {
    var tracker: Tracker?
    
    func createCalorieTracker(calorie: Int) {
          _ = Tracker(calories: calorie, date: Date())
        CoreDataStack.shared.saveToPersistentStore()
    }
    
    
}
