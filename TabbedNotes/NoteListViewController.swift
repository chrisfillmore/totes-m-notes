//
//  NoteListViewController.swift
//  TabbedNotes
//
//  Created by Tech on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit
import CoreData

class NoteListViewController: ListViewController {
    
    static let titleId = "title"
    static let bodyId = "body"
    let alertFieldNames = [titleId:"Title", bodyId:"Body"]
    let noteDetailSegueId = "NoteDetailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tags = getTags()
        
        fetchedResultsController.fetchedObjects!.forEach({ (_note:AnyObject) in
            let note = _note as! DTFNote
            if fetchedResultsController.indexPathForObject(note)!.row % 2 == 0 {
                
                //note.addTagObject(tags.first!)
                let relation = note.valueForKeyPath("tags") as! NSMutableSet
                relation.addObject(tags.first!)
            }
            for tag in note.tags! {
                print("in loop")
                print(tag)
            }
        })
        
    }

    override func onSave(fields:[String:String]?) {
        saveItem(fields)
    }
    
    override func getAlertTitle() -> String {
        return "New Note"
    }
    
    func getTags()->[DTFTag] {
        let fetchRequest = NSFetchRequest(entityName: "Tag")
        var results = [DTFTag]()
        
        do {
            results  = try managedObjectContext.executeFetchRequest(fetchRequest) as! [DTFTag]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return results
    }
    
    override func getAlertFieldNames() -> [String : String] {
        return alertFieldNames
    }
    
    override func getExtraActions() -> [String:(UIAlertAction) -> Void]? {
        
        return [
            "Open Details" : { (action: UIAlertAction) in
                
                self.performSegueWithIdentifier(self.noteDetailSegueId, sender: nil)
            }
        ]
    }
    
    override func getEntityName() -> String {
        return "Note"
    }
    
    override func getSortDescriptors()->[NSSortDescriptor] {
        return [NSSortDescriptor(key:NoteListViewController.titleId, ascending: true)]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(noteDetailSegueId, sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navCtrl = segue.destinationViewController
        let destCtrl = navCtrl.childViewControllers.first
        
        let index = sender as! NSIndexPath
        
        if segue.identifier == noteDetailSegueId {
            let noteDetailCtrl = destCtrl as! NoteDetailViewController
            let selectedNote = fetchedResultsController.objectAtIndexPath(index) as! DTFNote
            noteDetailCtrl.note = selectedNote
            noteDetailCtrl.saveDelegate = self
            noteDetailCtrl.tags = getTags()
        } else {
            // do nothing for now
        }

    }
    
    
}
