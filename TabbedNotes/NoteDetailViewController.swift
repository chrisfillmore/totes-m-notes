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
    
    var note:DTFNote?
    var saveDelegate:SaveItemDelegate?
    //var noteId:NSIndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        noteTitleField.text = note!.title
        noteBodyField.text = note!.body
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        /*let fields = [
            "title" : noteTitleField.text! as String,
            "body" : noteBodyField.text as String
        ]
        saveDelegate!.onSave(fields)*/
        //note!.setValue(noteTitleField.text!, forKey: "title")
        //note!.setValue(noteBodyField.text!, forKey: "body")
        note!.title = noteTitleField.text! as String
        note!.body = noteBodyField.text as String
        saveDelegate!.onSave(nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
