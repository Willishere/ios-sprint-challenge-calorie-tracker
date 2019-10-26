//
//  CoreDataStack.swift
//  Calorie Tracker
//
//  Created by William Chen on 10/26/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    private init() {}
    
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tracker")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                fatalError("Failed to load persistent store(s): \(error)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        })
        return container
    }()


    var mainContext: NSManagedObjectContext {
          container.viewContext
      }
    
      func saveToPersistentStore() {
          do {
              try mainContext.save()
          } catch {
              NSLog("Error saving context: \(error)")
              mainContext.reset()
          }
      }

    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var saveError: Error?
        context.performAndWait {
            do {
                try context.save()
            } catch {
                saveError = error
                NSLog("Error when saving: \(error)")
            }
        }
        if let saveError = saveError {
            throw saveError
        }
    }
}
