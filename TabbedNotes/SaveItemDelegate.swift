//
//  SaveItemDelegate.swift
//  TabbedNotes
//
//  Created by Tech on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit

protocol SaveItemDelegate {
    func onSave(fields:[String:String])
    //func onEdit(id:NSIndexPath, fields:[String:String])
}
