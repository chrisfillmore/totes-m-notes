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
        let tagCell = collectionView.dequeueReusableCellWithReuseIdentifier(tagCellID, forIndexPath: indexPath) as! CollectionViewCell
        tagCell.tagCellBtn.setTitle(tags[indexPath.row].description,
            forState: UIControlState.Normal)
        tagCell.backgroundColor = UIColor.whiteColor()
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
