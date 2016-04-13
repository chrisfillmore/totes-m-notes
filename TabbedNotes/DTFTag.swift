//
//  DTFTag.swift
//  TabbedNotes
//
//  Created by Tech on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//

import Foundation
import CoreData

@objc(DTFTag)
class DTFTag: NSManagedObject {

    override var description:String {
        return self.name!
    }
    
}
