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
    let cacheName = "secretCache"
    var tags = [DTFTag]()
    
    var fetchedResultsController: NSFetchedResultsController!
    var managedObjectContext:NSManagedObjectContext!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        managedObjectContext = getManagedObjectContext()
        fetchedResultsController = getFetchedResultsController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    func getFetchedResultsController()->NSFetchedResultsController {
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
        let alert = AlertHelper.createSaveAlert(self, title: getAlertTitle(), fieldNames: getAlertFieldNames(), extraActions: getExtraActions())
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = fetchedResultsController.sections!
        let sectionInfo = sections[section]
        print("Number of objects in section: " + String(sectionInfo.numberOfObjects))
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        configureCell(cell!, indexPath: indexPath)
        return cell!
    }
    
    func saveChanges() {
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
            managedObjectContext.deleteObject(item)
            saveChanges()
        }
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.textLabel!.text = getEntity(indexPath).description;
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
    
    func getExtraActions() -> [String:(UIAlertAction) -> Void]? {
        return nil
    }
    
    func onSave(fields:[String:String]?) {
        fatalError("Subclass must implement method onSave.")
    }
    
    func onEdit(row:NSIndexPath, fields:[String:String]) {
        fatalError("Subclass must implement method onEdit.")
    }
    
    func getEntityName()->String {
        fatalError("Subclass must implement method getEntityName.")
    }
    
    func getEntity(index:NSIndexPath)->NSManagedObject {
        return fetchedResultsController.objectAtIndexPath(index) as! NSManagedObject
    }
    
    func saveItem(data:[String:String]?) {
        let managedContext = getManagedObjectContext()
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            let item = getEntity(selectedIndexPath)
            if data != nil {
                for (key, value) in data! {
                    item.setValue(value, forKey: key)
                }
            }
        } else {
            let item = NSEntityDescription.insertNewObjectForEntityForName(getEntityName(), inManagedObjectContext: managedContext)
            if data != nil {
                for (key, value) in data! {
                    item.setValue(value, forKey: key)
                }
            }
        }
        saveChanges()
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Move:
            break
        case .Update:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            configureCell(self.tableView.cellForRowAtIndexPath(indexPath!)!, indexPath: indexPath!)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
}