//
//  CollectionViewCell.swift
//  TabbedNotes
//
//  Created by Tech on 2016-04-12.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit
import CoreData

class CollectionViewCell: UICollectionViewCell {
    
    var note:DTFNote!
    var cellTag:DTFTag!
    var managedObjectContext:NSManagedObjectContext!
    var hasTag:Bool = false
    
    @IBOutlet weak var tagCellBtn: UIButton!

    @IBAction func touchMe(sender: AnyObject) {
        
        let noteLocation = note.mutableSetValueForKey("tags")
        if hasTag {
            noteLocation.removeObject(cellTag)
            self.backgroundColor = UIColor.whiteColor()
            self.hasTag = false
        } else {
            noteLocation.addObject(cellTag)
            self.backgroundColor = UIColor.blueColor()
            self.hasTag = true
        }
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
                
    }
    

    
}
