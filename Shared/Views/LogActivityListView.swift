//
//  LogActivityListView.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 11/07/2021.
//

import SwiftUI

struct LogActivityListView: View {
    
    let coreDM: CoreDataManager
    
    @State private var logRecords: [LogRecord] = []
    @State private var activityName: String = ""
    @State private var refreshRequired: Bool = false
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
                HStack {
                    Text(logRecord.activityName ?? "").bold()
                    Text(logRecord.startTime?.formatted(.dateTime.year().day().month().hour().minute().second()) ?? "").fontWeight(.light)
                    Spacer()
                    if logRecord.endTime == nil {
                        HStack {
                            Text("\(logRecord.startTime!.difference())")
                            Button {
                                logRecord.endTime = Date()
                                coreDM.updateLogRecord()
                                refreshRequired.toggle()
                            } label: {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let logRecord = logRecords[index]
                    coreDM.deleteLogRecord(logRecord: logRecord)
                    populateLogRecords()
                }
            }
            .searchable(text: $searchText)
        }
        .task { populateLogRecords() }

        
        
        
    }
    
    func populateLogRecords() {
        logRecords = coreDM.getAllLogRecords()
    }
}

struct LogActivityListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let coreDmPreview = CoreDataManager()
        LogActivityListView(coreDM: coreDmPreview)
    }
}
