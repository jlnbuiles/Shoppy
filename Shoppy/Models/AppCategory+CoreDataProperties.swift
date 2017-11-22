//
//  AppCategory+CoreDataProperties.swift
//  Shoppy
//
//  Created by Julian Builes on 2/8/16.
//  Copyright © 2016 Grability. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AppCategory {

    @NSManaged var name: String?
    @NSManaged var resultsCount: Int16
    @NSManaged var id: String?
    @NSManaged var app: NSSet?

}
