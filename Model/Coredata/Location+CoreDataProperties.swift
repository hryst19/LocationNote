//
//  Location+CoreDataProperties.swift
//  LocationNotes
//
//  Created by hryst on 6/24/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var note: Note?

}
