//
//  ContentView.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 02/07/2021.
//

import SwiftUI

struct ContentView: View {
    let coreDM = CoreDataManager()
    @State private var logRecords: [LogRecord] = []
    @State private var activityName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Description", text: $activityName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button("Start recording") {
                    coreDM.saveLogRecord(title: activityName)
                    populateLogRecords()
                }
                
                List {
                    ForEach(logRecords, id: \.self) { logRecord in
                        HStack {
                            Text(logRecord.activityName ?? "")
                            Text(logRecord.startTime?.formatted(.dateTime.year().day().month().hour().minute().second()) ?? "")
                            Spacer()
                            if logRecord.endTime == nil {
                                
                                Button {
                                    print("Button pressed")
                                    logRecord.endTime = Date()
                                    coreDM.updateLogRecord()
                                } label: {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.red)
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
                }
            }
            .navigationTitle("Log records")
            .task { populateLogRecords() }
        }
    }
    
    func populateLogRecords() {
        logRecords = coreDM.getAllLogRecords()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
