//
//  Tracker+Convenience.swift
//  Calorie Tracker
//
//  Created by William Chen on 10/26/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import CoreData
extension Tracker {
    @discardableResult convenience init (calories: Int, date: Date, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.calories = Int64(calories)
        self.date = date
    }
    
}
