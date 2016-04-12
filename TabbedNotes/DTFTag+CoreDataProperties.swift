//
//  DTFTag+CoreDataProperties.swift
//  TabbedNotes
//
//  Created by Tech on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension DTFTag {

    @NSManaged var name: String?
    @NSManaged var notes: NSSet?

}
