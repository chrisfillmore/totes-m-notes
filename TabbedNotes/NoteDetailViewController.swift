//
//  NoteDetailViewController.swift
//  TabbedNotes
//
//  Created by Chris on 2016-04-08.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteBodyField: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let tagCellID = "TagCell"
    
    var note:DTFNote?
    var saveDelegate:SaveItemDelegate?
    var tags = [DTFTag]()
    var managedObjectContext:NSManagedObjectContext!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        if note!.title != nil {
            noteTitleField.text = note!.title
            noteBodyField.text = note!.body
        } else {
            noteTitleField.text = ""
            noteBodyField.text = ""
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var hasTag:Bool = false
        let tagCell = collectionView.dequeueReusableCellWithReuseIdentifier(tagCellID, forIndexPath: indexPath) as! CollectionViewCell
        tagCell.tagCellBtn.setTitle(tags[indexPath.row].description,
            forState: UIControlState.Normal)
        tagCell.cellTag = tags[indexPath.row]
        tagCell.note = note
        tagCell.managedObjectContext = managedObjectContext
        tagCell.layer.cornerRadius = 5
        tagCell.tagCellBtn.titleEdgeInsets.left = 4
        tagCell.tagCellBtn.titleEdgeInsets.right = 4
        tagCell.tagCellBtn.titleEdgeInsets.top = 4
        tagCell.tagCellBtn.titleEdgeInsets.bottom = 4
        
        for e in note!.tags!
        {
            if e.description == tags[indexPath.row].description
            {
                hasTag = true
            }
        }
        
        tagCell.hasTag = hasTag
        
        if hasTag {
            tagCell.backgroundColor = UIColor.blueColor()
        } else {
            tagCell.backgroundColor = UIColor.whiteColor()
        }
        
        return tagCell
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
       // if note == nil {
       //  let note = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: <#T##NSManagedObjectContext#>)
       // }
        
        note!.title = noteTitleField.text! as String
        note!.body = noteBodyField.text as String
        saveDelegate!.onSave(nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
