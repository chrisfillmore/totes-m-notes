//
//  TagListViewController.swift
//  TabbedNotes
//
//  Created by Chris on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit
import CoreData

class TagListViewController: ListViewController {
    
    static let nameId = "name"
    let alertFieldNames = [nameId:"Name"]
    let searchByTagSegue = "SearchByTag"

    override func onSave(fields:[String:String]?) {
        // should add a check in here to see if it's blank
        saveItem(fields)
        self.tableView.reloadData()
    }
    
    override func getAlertTitle() -> String {
        return "New Tag"
    }
    
    override func getAlertFieldNames() -> [String : String] {
        return alertFieldNames
    }
    
    override func getEntityName() -> String {
        return "Tag"
    }
    
    
    override func getSortDescriptors()->[NSSortDescriptor] {
        return [NSSortDescriptor(key:TagListViewController.nameId, ascending: true)]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(searchByTagSegue, sender: indexPath)
    }
    /*
    func getNotesByTag(tag:DTFTag)->[DTFNote] {
        let fetchRequest = NSFetchRequest(entityName: "Note")
        
        var results = []
        
        do {
            results  = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        print("here are all the results")
        for result in results {
            print(result)
        }
        
        
        let predicate = NSPredicate(format: "%@ in tags", tag.name!)
        results = (results as NSArray).filteredArrayUsingPredicate(predicate)
        
        print("here are the results by tag")
        for result in results {
            print(result)
        }
        
        return results as! [DTFNote]
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let noteCtrl = segue.destinationViewController as! NoteListViewController
        
        let index = sender as! NSIndexPath
        
        if segue.identifier == searchByTagSegue {
            let tag = fetchedResultsController.objectAtIndexPath(index) as! DTFTag
            noteCtrl.predicate = NSPredicate(format: "%@ in tags", tag.name!)
            tabBarController!.selectedViewController = tabBarController!.viewControllers!.first
        } else {
            // do nothing for now
        }
        
    }
    
}
