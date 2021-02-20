//
//  ImageNote+CoreDataProperties.swift
//  LocationNotes
//
//  Created by hryst on 6/24/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageNote> {
        return NSFetchRequest<ImageNote>(entityName: "ImageNote")
    }

    @NSManaged public var imageBig: NSData?
    @NSManaged public var note: Note?

}
