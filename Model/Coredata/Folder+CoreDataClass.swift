//
//  Folder+CoreDataClass.swift
//  LocationNotes
//
//  Created by hryst on 6/24/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {
    
    class func newFolder(name: String) -> Folder {
        
      let folder = Folder(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        folder.name = name
        folder.dataUpdate = Date()
        
        return folder
    }

    func addNote() -> Note {
        let newNote = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
     
      newNote.folder = self
      newNote.dateUpdate = Date()
        
        return newNote
        
    }
    //сортировка
    var notesSorted: [Note] {
        
        let sortDescriptor = NSSortDescriptor(key: "dateUpdate", ascending: false)
        
        self.notes?.sortedArray(using: [sortDescriptor])
        
        return self.notes?.sortedArray(using: [sortDescriptor]) as! [Note]
    }
    
    
}
