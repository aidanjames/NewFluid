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
    @Published var logRecords: [LogRecord2] = []
    
    
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
    
    func saveCategories() {
        FileManager.default.writeData(activities, to: "categories")
    }
    
    func saveCategory(_ category: Category) {
        if let index = self.categories.firstIndex(where: { $0.id == category.id }) {
            categories[index] = category
            saveCategories()
        }
    }
    
    func deleteCategory(_ category: Category) {
        if let index = self.categories.firstIndex(where: { $0.id == category.id }) {
            categories.remove(at: index)
            saveCategories()
        }
    }
    
    func editCategory(_ category: Category) {
        if let index = self.activities.firstIndex(where: { $0.id == category.id }) {
            categories[index] = category
            saveCategories()
        }
    }
    
    
    // Avctivities
    
    func fetchActivities() {
        if let activities: [Activity] = FileManager.default.fetchData(from: "activities") {
            self.activities = activities
        }
    }
    
    func saveActivities() {
        FileManager.default.writeData(self.activities, to: "activities")
    }
    
    func saveActivity(_ activity: Activity) {
        if let index = self.activities.firstIndex(where: { $0.id == activity.id }) {
            activities[index] = activity
            saveActivities()
        }
    }
    
    func deleteActivity(_ activity: Activity) {
        if let index = self.categories.firstIndex(where: { $0.id == activity.id }) {
            activities.remove(at: index)
            saveActivities()
        }
    }
    
    
    // Log records
    
    func fetchLogRecords() {
        if let logRecords: [LogRecord2] = FileManager.default.fetchData(from: "logRecords") {
            self.logRecords = logRecords
        }
    }
    
    func saveLogRecords() {
        FileManager.default.writeData(self.logRecords, to: "LogRecords")
    }
    
    func saveLogRecord(_ logRecord: LogRecord2) {
        if let index = self.activities.firstIndex(where: { $0.id == logRecord.id }) {
            logRecords[index] = logRecord
            saveLogRecords()
        }
    }
    
    func deleteLogRecord(_ logRecord: LogRecord2) {
        if let index = self.activities.firstIndex(where: { $0.id == logRecord.id }) {
            logRecords.remove(at: index)
            saveLogRecords()
        }
    }

}
