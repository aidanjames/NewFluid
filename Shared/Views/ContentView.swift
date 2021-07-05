//
//  ContentView.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 02/07/2021.
//

import SwiftUI

struct ContentView: View {
    let context = CoreDataManager().persistentContainer.viewContext
    @State private var activityName: String = ""
    @State private var activeLogRecord: LogRecord?
    
    var body: some View {
        VStack {
            Text(activeLogRecord != nil ? "Recording" : "")
            TextField("Description", text: $activityName)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("\(activeLogRecord != nil ? "Stop" : "Start") recording") {
                buttonPressed()
            }
        }
    }
    
    func buttonPressed() {
        
        if activeLogRecord == nil {
            let newLogRecord = LogRecord(context: context)
            newLogRecord.activityName = activityName
            newLogRecord.startTime = Date()
            activeLogRecord = newLogRecord
        } else {
            activeLogRecord?.endTime = Date()
            do {
                try context.save()
            } catch {
                print("Error")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
