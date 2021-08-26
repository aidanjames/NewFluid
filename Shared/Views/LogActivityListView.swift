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
    @State private var searchingIsAllowed = false
    @StateObject var pomodoroSessionVM = PomodoroSessionViewModel()
    
    // To be replaced with a view model
    @State private var currentSessionStartTime: Date? = Date()
    @State private var currentSessionEndTime: Date? = Date().addingTimeInterval(30)
    @State private var currentSessionType: SessionType = .regularSession
    
    
    var filteredLogRecords: [LogRecord] {
        if searchText.isEmpty {
            return logRecords.sorted { $0.startTime! > $1.startTime! }
        } else {
            return logRecords.filter {
                $0.activityName!.lowercased().contains(searchText.lowercased()) }.sorted { $0.startTime! > $1.startTime! }
        }
    }
    
    var body: some View {

            List {
                
                VStack {
                    PomodoroView(currentSessionType: $currentSessionType, currentSessionStartTime: $currentSessionStartTime, currentSessionEndTime: $currentSessionEndTime)
                    
                    Button(action: {
                        if currentSessionStartTime == nil {
                            currentSessionStartTime = Date()
                            currentSessionEndTime = Date().addingTimeInterval(1500)
                        } else {
                            currentSessionStartTime = nil
                            currentSessionEndTime = nil
                        }
                    } ) {
                        Text(currentSessionStartTime != nil ? "Stop pomodoro" : "Start pomodoro")
                    }
                    .buttonStyle(.bordered )
                    .controlSize(.large)
                    .padding(.top)
                }
                
                ForEach(filteredLogRecords, id: \.self) { logRecord in
                    ActivityView(logRecord: logRecord, coreDM: coreDM, refreshRequired: $refreshRequired, logRecords: $logRecords)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let logRecord = filteredLogRecords[index]
                        coreDM.deleteLogRecord(logRecord: logRecord)
                        refreshRequired.toggle()
                        populateLogRecords()
                    }
                }
                .accentColor(refreshRequired ? .blue : .blue) // Workaround so list updates following .updateLogRecord()
                
            }
            .task { populateLogRecords() }
            .if(searchingIsAllowed, transform: { view in
                view.searchable(text: $searchText, placement: .navigationBarDrawer)
            })
                .toolbar {
                ToolbarItem {
                    Button("\(searchingIsAllowed ? "Hide search" : "Search")") {
                        searchingIsAllowed.toggle()
                    }
                }
            }
        
        
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
