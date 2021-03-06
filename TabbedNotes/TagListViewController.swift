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

    override func onSave(fields:[String:String]) {
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
    
}
