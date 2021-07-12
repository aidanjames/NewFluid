//
//  ContentView.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 02/07/2021.
//

import SwiftUI

struct ContentView: View {
    let coreDM = CoreDataManager()
    @StateObject var timer = TimerManager()
    @State private var activityName: String = ""
    @State private var refreshRequired: Bool = false
    @State private var logRecords: [LogRecord] = []

    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Description", text: $activityName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Start recording") {
                    coreDM.saveLogRecord(title: activityName)
                    activityName = ""
                    populateLogRecords()
                    refreshRequired.toggle()
                }
                .disabled(activityName.isEmpty)
                
                LogActivityListView(coreDM: coreDM, refreshRequired: $refreshRequired, timer: timer, logRecords: $logRecords)

            }
            .navigationTitle("Log records")
            
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
