//
//  App+CoreDataProperties.swift
//  Shoppy
//
//  Created by Julian Builes on 2/9/16.
//  Copyright © 2016 Grability. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension App {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var price: Float
    @NSManaged var summary: String?
    @NSManaged var imageURL: String?
    @NSManaged var category: AppCategory?

}
