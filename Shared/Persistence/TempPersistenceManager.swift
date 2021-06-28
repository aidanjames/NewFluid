//
//  TempPersistenceManager.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 28/06/2021.
//

import Foundation

class TempPersistenceManager: ObservableObject {
    static let shared = TempPersistenceManager()
    
    @Published var categories: [Category] = []
    @Published var activities: [Activity] = []
    @Published var logRecords: [LogRecord] = []
    
    
    private init() {
        fetchCategories()
        fetchActivities()
        fetchLogRecords()
    }
    
    
    // Categories
    
    func fetchCategories() {
        if let categories: [Category] = FileManager.default.fetchData(from: "categories") {
            self.categories = categories
        }
    }
    
    func saveCategory(_ category: Category) {
        // TODO
    }
    
    func deleteCategory(_ category: Category) {
        // TODO
    }
    
    func editCategory(_ category: Category) {
        // TODO
    }
    
    
    // Avctivities
    
    func fetchActivities() {
        if let activities: [Activity] = FileManager.default.fetchData(from: "activities") {
            self.activities = activities
        }
    }
    
    func saveActivities(_ activities: [Activity]) {
        FileManager.default.writeData(activities, to: "activities")
    }
    
    func saveActivity(_ activity: Activity) {
        // TODO
    }
    
    func deleteActivity(_ activity: Activity) {
        // TODO
    }
    
    
    // Log records
    
    func fetchLogRecords() {
        if let logRecords: [LogRecord] = FileManager.default.fetchData(from: "logRecords") {
            self.logRecords = logRecords
        }
    }
    
    func saveLogRecords(_ logRecords: [LogRecord]) {
        FileManager.default.writeData(logRecords, to: "LogRecords")
    }
    
    func saveLogRecord(_ logRecord: LogRecord) {
        // TODO
    }
    
    func deleteLogRecord(_ logRecord: LogRecord) {
        // TODO
    }

}
