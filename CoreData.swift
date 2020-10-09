//
//  CoreData.swift
//  FinStructure
//
//  Created by Rupa Divya on 24/9/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreData{
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        return context
    }()
    
    // Insert note
    static func newNote() -> NotesInfo {
        let note = NSEntityDescription.insertNewObject(forEntityName: "NotesInfo", into: context) as! NotesInfo
        return note
    }
    
    // Read note
    static func retrieveNotes(with fetchRequest: NSFetchRequest<NotesInfo> = NotesInfo.fetchRequest()) -> [NotesInfo] {
        do {
            let results = try context.fetch(fetchRequest)
            return results            
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            return []
        }
    }
    
    // Save Note
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Error saving the Note \(error.localizedDescription)")
        }
    }
    
    // Delete note
    static func delete(note: NotesInfo) {
        context.delete(note)
        saveNote()
    }
}
