//
//  LogActivityListView.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 11/07/2021.
//

import SwiftUI

struct LogActivityListView: View {
    
    let coreDM: CoreDataManager
    @Binding var refreshRequired: Bool    
    @Binding var logRecords: [LogRecord]
    @State private var activityName: String = ""
    @State private var searchText: String = ""
    
    var filteredLogRecords: [LogRecord] {
        if searchText.isEmpty {
            return logRecords
        } else {
            return logRecords.filter {
                $0.activityName!.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredLogRecords, id: \.self) { logRecord in
                ActivityView(logRecord: logRecord, coreDM: coreDM, refreshRequired: $refreshRequired, logRecords: $logRecords)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let logRecord = logRecords[index]
                    coreDM.deleteLogRecord(logRecord: logRecord)
                    refreshRequired.toggle()
                    populateLogRecords()
                }
            }
            .accentColor(refreshRequired ? .blue : .blue) // Workaround so list updates following .updateLogRecord()
            
        }
        .task { populateLogRecords() }
        .searchable(text: $searchText)
        
    }
    
    func populateLogRecords() {
        logRecords = coreDM.getAllLogRecords()
    }
}

struct LogActivityListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let coreDmPreview = CoreDataManager()
        LogActivityListView(coreDM: coreDmPreview, refreshRequired: .constant(false), logRecords: .constant([]))
    }
}
