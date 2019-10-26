//
//  CalorieTableViewController.swift
//  Calorie Tracker
//
//  Created by William Chen on 10/18/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit
import SwiftChart
import CoreData

class CalorieTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var chart: Chart!
    var controller = TrackerController()
    
    lazy var fetchResultsController: NSFetchedResultsController<Tracker> = {
            let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
        let calorieDescriptor = NSSortDescriptor(key: "date", ascending: false)
        
        let moc = CoreDataStack.shared.container.newBackgroundContext()
        fetchRequest.sortDescriptors = [calorieDescriptor]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        return frc
    }()
    
    func updateBody() -> NSFetchedResultsController<Tracker>{
        
        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
              let calorieDescriptor = NSSortDescriptor(key: "date", ascending: false)
              
              let moc = CoreDataStack.shared.container.newBackgroundContext()
              fetchRequest.sortDescriptors = [calorieDescriptor]
              let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
              frc.delegate = self
              do {
                  try frc.performFetch()
              } catch {
                  fatalError("Error performing fetch for frc: \(error)")
              }
              return frc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        updateViews()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func updateViews(){
        guard let fetchedObjects = fetchResultsController.fetchedObjects else {return}
         var calories:[Double] = fetchedObjects.map{Double($0.calories)}
         calories.reverse()
         let series = ChartSeries(calories)
         series.color = ChartColors.greenColor()
         chart.removeAllSeries()
         chart.add(series)
        
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? CalorieTableViewCell else {return UITableViewCell()}
        
        guard var calories = fetchResultsController.fetchedObjects else {return UITableViewCell()}
       
        
        cell.tracker = calories[indexPath.row]
    

        // Configure the cell...

        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Enter Calories", message: "", preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert]_ in
            guard let alert = alert,
                let textFields = alert.textFields,
                let text = textFields[0].text,
                let calorie = Int(text)
                else { return }
            
            self.controller.createCalorieTracker(calorie: calorie)
            
           
            self.fetchResultsController = self.updateBody()
            DispatchQueue.main.async{
                self.tableView.reloadData()
                self.updateViews()
            }
            
        }))
            self.present(alert, animated: true, completion: nil)
    }
}
