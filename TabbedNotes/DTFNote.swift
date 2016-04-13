//
//  DTFNote.swift
//  TabbedNotes
//
//  Created by Tech on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//

import Foundation
import CoreData

@objc(DTFNote)
class DTFNote: NSManagedObject {

    override var description:String {
        if self.title == nil {
            self.title = ""
        }
        if self.body == nil {
            self.body = ""
        }
        
        return self.title! + " : " + self.body!
    }
}
