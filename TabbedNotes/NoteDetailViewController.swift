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
        noteTitleField.text = note!.title
        noteBodyField.text = note!.body
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
        note!.title = noteTitleField.text! as String
        note!.body = noteBodyField.text as String
        saveDelegate!.onSave(nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
