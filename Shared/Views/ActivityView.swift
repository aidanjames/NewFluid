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
            
            VStack(alignment: .leading) {
                Text(logRecord.activityName ?? "").bold().padding(.bottom, 3)
                Text("Start: \(logRecord.startTime?.formatted(.dateTime.day().month().hour().minute().second()) ?? "")").fontWeight(.light).font(.caption2)
                if logRecord.endTime != nil {
                    Text("End:   \(logRecord.endTime?.formatted(.dateTime.day().month().hour().minute().second()) ?? "")").fontWeight(.light).font(.caption2)
                }
            }
            
            Spacer()
            
            if logRecord.endTime == nil {
                HStack {
                    Text("\(logRecord.startTime?.secondsSinceDate().secondsToHoursMinsSecs() ?? "")")
                        .font(Font.system(.body).monospacedDigit())
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
