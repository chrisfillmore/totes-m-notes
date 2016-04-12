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
        // cast to the right type
        // this is a bit ghetto
        items = items as! [DTFNote]
    }

    override func onSave(fields:[String:String]) {
        saveItem(fields)
        self.tableView.reloadData()
    }
    
    override func onEdit(row:NSIndexPath, fields:[String:String]) {
        for (key, value) in fields {
            print(key + " = " + value)
        }
    }
    
    override func getAlertTitle() -> String {
        return "New Note"
    }
    
    override func getAlertFieldNames() -> [String : String] {
        return alertFieldNames
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
            let selectedNote = items[index.row] as! DTFNote
            noteDetailCtrl.note = selectedNote
            noteDetailCtrl.saveDelegate = self
            //noteDetailCtrl.noteId = index
        } else {
            // do nothing for now
        }

    }
    
    
}
