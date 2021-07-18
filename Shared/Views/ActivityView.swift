//
//  ActivityView.swift
//  NewFluid
//
//  Created by Aidan Pendlebury on 15/07/2021.
//

import SwiftUI

struct ActivityView: View {
    
    var logRecord: LogRecord
    
    @Binding var refreshRequired: Bool
    @EnvironmentObject var timer: TimerManager
    
    var body: some View {
        HStack {
            
            Text(logRecord.activityName ?? "").bold()
            Text(logRecord.startTime?.formatted(.dateTime.year().day().month().hour().minute().second()) ?? "").fontWeight(.light)
            Spacer()
            if logRecord.endTime == nil {
                HStack {
                    Text("\(logRecord.startTime!.secondsSinceDate().secondsToHoursMinsSecs())")
                        .font(.system(.body, design: .monospaced))
                    Button {
                        logRecord.endTime = Date()
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
}

struct ActivityView_Previews: PreviewProvider {

    
    static var previews: some View {
        
        let coreDM = CoreDataManager()
        let logRecord = LogRecord(context: coreDM.persistentContainer.viewContext)
        logRecord.activityName = "Discovery"
        logRecord.startTime = Date()
        
        return ActivityView(logRecord: logRecord, refreshRequired: .constant(false))
    }
}
