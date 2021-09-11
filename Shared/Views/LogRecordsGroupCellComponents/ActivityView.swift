//
//  ActivityView.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 15/07/2021.
//

import SwiftUI

struct ActivityView: View {
    
    var logRecord: LogRecord
    var coreDM: CoreDataManager
        
    @Binding var refreshRequired: Bool
    @Binding var logRecords: [LogRecord]
    @EnvironmentObject var timer: TimerManager
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(logRecord.activityName ?? "").bold().padding(.bottom, 3)
                Text("Start: \(logRecord.startTime?.formatted(.dateTime.day().month().hour().minute().second()) ?? "")").fontWeight(.light).font(.caption2)
                Text("End:   \(logRecord.endTime?.formatted(.dateTime.day().month().hour().minute().second()) ?? "Logging")").fontWeight(.light).font(.caption2).foregroundColor(logRecord.endTime == nil ? .red : .primary)
            }
            
            Spacer()
            
            if logRecord.endTime == nil {
                VStack {
                    HStack {
                        ActiveTimerCounterView(startTime: logRecord.startTime ?? Date())
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.red)
                            .onTapGesture {
                                logRecord.endTime = Date()
                                refreshRequired.toggle()
                                coreDM.updateLogRecord()
                            }
                    }
                    Image(systemName: "tray.and.arrow.up.fill")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            let activityNameUnwrapped = logRecord.activityName ?? "Issue"
                            // TODO - Allow the user to specify a date for the reminder
                            ThingsManager.shared.newToDo(title: activityNameUnwrapped, date: Date())
                        }
                }
                
            } else {
                Image(systemName: "play.fill")
                    .foregroundColor(.green)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        startNewRecordingForExistingActivity(activityName: logRecord.activityName ?? "")
                    }
            }
        }
    }
    
    func startNewRecordingForExistingActivity(activityName: String) {
        // TODO
        print(activityName)
        coreDM.saveLogRecord(title: activityName)
        logRecords = coreDM.getAllLogRecords()
        refreshRequired.toggle()
    }
    
}

struct ActivityView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let coreDM = CoreDataManager()
        let logRecord = LogRecord(context: coreDM.persistentContainer.viewContext)
        logRecord.activityName = "Discovery"
        logRecord.startTime = Date()
        
        return ActivityView(logRecord: logRecord, coreDM: coreDM, refreshRequired: .constant(false), logRecords: .constant([]))
    }
}
