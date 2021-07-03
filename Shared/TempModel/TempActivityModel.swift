//
//  TempActivityModel.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 28/06/2021.
//

import Foundation

struct Category: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
}

struct Activity: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var category: Category?
    var logRecords: [LogRecord2]
}

struct LogRecord2: Identifiable, Codable {
    var id: UUID = UUID()
    var startTime: Date
    var endTime: Date?
}
