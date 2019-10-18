//
//  Model.swift
//  Calorie Tracker
//
//  Created by William Chen on 10/18/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation

class Results{
    var results: [TrackerRepresentation] = []
}

class TrackerRepresentation{
    var calories: Int?
    var date: Date?
}
