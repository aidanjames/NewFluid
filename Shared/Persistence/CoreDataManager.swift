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
    
    
    func saveLogRecord(title: String) {
        
        let logRecord = LogRecord(context: persistentContainer.viewContext)
        logRecord.activityName = title
        logRecord.startTime = Date()

        do {
            try persistentContainer.viewContext.save()
            print("Log record saved.")
        } catch {
            print("Failed to save movie: \(error)")
            persistentContainer.viewContext.rollback()
        }
    }
    
    
    func updateLogRecord() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Couldn't update log record.")
            persistentContainer.viewContext.rollback()
        }
    }
    
    
    func deleteLogRecord(logRecord: LogRecord) {
        persistentContainer.viewContext.delete(logRecord)
        
        do {
            try persistentContainer.viewContext.save()
            print("Log record deleted.")
        } catch {
            print("Failed to delete log record: \(error)")
            persistentContainer.viewContext.rollback()
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
