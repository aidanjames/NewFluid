//
//  CoreDataManager.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 02/07/2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentCloudKitContainer(name: "NewFluid")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed to initialise \(error.localizedDescription)")
            }
        }
    }
    
    
    func saveMovie(title: String) {
        
        let logRecord = LogRecord(context: persistentContainer.viewContext)
        logRecord.activityName = title
        logRecord.startTime = Date()

        do {
            try persistentContainer.viewContext.save()
            print("Movie saved.")
        } catch {
            print("Failed to save movie: \(error)")
        }
    }
    
    
    func getAllLogRecords() -> [LogRecord] {
        
        let fetchRequest: NSFetchRequest<LogRecord> = LogRecord.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch log records: \(error)")
            return []
        }
    }
    
    
}
