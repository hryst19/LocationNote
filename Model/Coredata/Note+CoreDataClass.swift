//
//  Note+CoreDataClass.swift
//  LocationNotes
//
//  Created by hryst on 6/24/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


@objc(Note)
public class Note: NSManagedObject {
    
    class func newNote(name: String, inFolder: Folder?) -> Note {
     let newNote = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        newNote.name = name
        newNote.dateUpdate = Date()
        
        if let inFolder = inFolder {
            newNote.folder = inFolder
        }
        
        return newNote
    }
    
    var imageActual: UIImage? {
        set {
            if newValue == nil {
                if self.image != nil {
                    CoreDataManager.sharedInstance.managedObjectContext.delete(self.image!)
                }
                self.imageSmall = nil
            } else {
                if self.image == nil {
                    self.image = ImageNote(context: CoreDataManager.sharedInstance.managedObjectContext)
                }
                
            self.image?.imageBig = newValue?.jpegData(compressionQuality: 1) as NSData?
            self.imageSmall = newValue?.jpegData(compressionQuality: 0.05) as NSData?
            }
            dateUpdate = Date()
        }
        get {
            if self.image != nil {
                if image?.imageBig != nil {
                    return UIImage(data: self.image!.imageBig! as Data)
                }
            }
            return nil
        }
    }
    
    var locationActual: LocationCoordinate? {
        get {
            if self.location == nil {
                return nil
            } else {
                return LocationCoordinate(lat: self.location!.lat, lon: self.location!.lon)
            }
        }
        
        set {
            
            if newValue == nil && self.location != nil {
                // удаляю локацию
                CoreDataManager.sharedInstance.managedObjectContext.delete(self.location!)
            }
            
            if newValue != nil && self.location != nil {
                //   обновить локацию
                self.location?.lat = newValue!.lat
                self.location?.lon = newValue!.lon
            }
            
            if newValue != nil && self.location == nil {
                // создаю локацию
                let newLocation = Location(context: CoreDataManager.sharedInstance.managedObjectContext)
                newLocation.lat = newValue!.lat
                newLocation.lon = newValue!.lon
                
                self.location = newLocation
         
            }
        }
        
    }
    
    func addCurrentLocation () {
        LocationManager.sharedInstance.getCurrentLocation { (location) in
            self.locationActual = location
            print("Получили новую локацию: \(location)")
        }
    }
    
    
    func addImage(image: UIImage) {
     let imageNote = ImageNote(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        imageNote.imageBig = image.jpegData(compressionQuality: 1) as NSData?
        
        self.image = imageNote
    }
    
    func addLocation(latitude: Double, lontitude: Double) {
        let location = Location(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        location.lat = latitude
        location.lon = lontitude
        
        self.location = location
        
    }
    
    //    var dateUpdateString: String {
    //
    ////
    //////        let now  = Date()
    //////        let newNoteDate = Date(timeIntervalSinceNow: -60)
    //////
    //////        extension Date {
    //////            func timeAgoDisplay() -> String {
    //////                return ""
    ////            }
    ////        }
    //      let df = DateFormatter()
    //        df.dateStyle = .medium
    //        df.timeStyle = .short
    //
    //
    //
    //        return df.string(from: self.dateUpdate! as Date)
    //    }
   
 
    
}
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let now = Date()
        
 
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        } else if secondsAgo > week || secondsAgo < week * 2 {
        return "\(secondsAgo / week) week ago"
        }
        return "\(now)"
    }
}
