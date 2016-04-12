//
//  DTFNote+CoreDataProperties.swift
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

extension DTFNote {

    @NSManaged var title: String?
    @NSManaged var body: String?
    @NSManaged var tags: NSSet?

}
