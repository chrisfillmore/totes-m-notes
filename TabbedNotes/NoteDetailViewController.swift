//
//  NoteDetailViewController.swift
//  TabbedNotes
//
//  Created by Chris on 2016-04-08.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit

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
        let fields = [
            "title" : noteTitleField.text! as String,
            "body" : noteBodyField.text as String
        ]
        saveDelegate!.onSave(fields)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
