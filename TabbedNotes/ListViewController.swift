//
//  ListViewController.swift
//  TabbedNotes
//
//  Created by Chris on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController, SaveItemDelegate, NSFetchedResultsControllerDelegate {
    
    let cellId = "Cell"
    
    var fetchedResultsController: NSFetchedResultsController! = nil
    
    var items = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchedResultsController = getFetchedResultsController()
        
        let managedContext = getManagedObjectContext()
        let fetchRequest = NSFetchRequest(entityName: getEntityName())
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            items = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func getFetchedResultsController()->NSFetchedResultsController {
        if fetchedResultsController != nil {
            return fetchedResultsController
        }
        
        let request = NSFetchRequest(entityName: getEntityName())
        request.sortDescriptors = getSortDescriptors()
        
        let context = getManagedObjectContext()
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
        return frc
    }
    
    func getManagedObjectContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }
    
    @IBAction func addButton(sender: AnyObject) {
        let alert = AlertHelper.createSaveAlert(self, title: getAlertTitle(), fieldNames: getAlertFieldNames())
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func tableView(TableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        cell!.textLabel!.text = items[indexPath.row].description;
        return cell!
    }
    
    func getSortDescriptors()->[NSSortDescriptor] {
        fatalError("Subclass must implement method getSortDescriptors.")
    }
    
    func getAlertTitle()->String {
        return "New Item"
    }
    
    func getAlertFieldNames() -> [String:String] {
        return [:]
    }
    
    func onSave(fields:[String:String]) {
        fatalError("Subclass must implement method onSave.")
    }
    
    func onEdit(row:NSIndexPath, fields:[String:String]) {
        fatalError("Subclass must implement method onEdit.")
    }
    
    func getEntityName()->String {
        fatalError("Subclass must implement method getEntityName.")
    }
    
    func saveItem(data:[String:String]) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            let item = items[selectedIndexPath.row]
            for (key, value) in data {
                item.setValue(value, forKey: key)
            }
        } else {
            let managedContext = getManagedObjectContext()
            let entity = NSEntityDescription.entityForName(getEntityName(), inManagedObjectContext: managedContext)
            let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            for (key, value) in data {
                item.setValue(value, forKey: key)
            }
            
            do {
                try managedContext.save()
                items.append(item)
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        
            
    }
    /*
    func saveItem(data:[String:String], index:NSIndexPath) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            var item = items[index.row]
            for (key, value) in data {
                item.setValue(value, forKey: key)
 
                do {
                    //try item.setValue(value, forKey: key)
                    try item[key] = value
                } catch let error as NSError {
                    print("Could not update \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func editItem(row:NSIndexPath, data: [String:String]) {
        //let managedContext = getManagedObjectContext()
        //let fetchRequest = NSFetchRequest(entityName: getEntityName())
        //fetchRequest.predicate = NSPredicate(format: , <#T##args: CVarArgType...##CVarArgType#>)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //
        }
    }*/
    /*
    func getItem(selectedCell:UITableViewCell?)->NSManagedObject {
        let indexPath = tableView.indexPathForCell(selectedCell!)
        return getItem(indexPath!)
    }
 
    func getItem(index:NSIndexPath)->NSManagedObject {
        return items[index.row]
    }
    */
}
