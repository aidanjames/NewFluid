//
//  PomodoroView.swift
//  PomodoroView
//
//  Created by Aidan Pendlebury on 29/07/2021.
//

import SwiftUI

struct PomodoroView: View {
    
    @Binding var currentSessionType: SessionType
    @Binding var currentSessionStartTime: Date?
    @Binding var currentSessionEndTime: Date?
    @EnvironmentObject var timer: TimerManager
    
    var barColor: Color {
        switch currentSessionType {
        case .regularSession:
            return .red
        case .shortBreak:
            return .green
        case .longBreak:
            return .blue
        }
    }
    
    var progress: Double {
        guard let startTime = currentSessionStartTime else { return 0 }
        guard let endTime = currentSessionEndTime else { return  0 }
        return (abs(startTime.secondsSinceDate()) / endTime.timeIntervalSince(startTime)) * 100
        
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                HStack {
                    if let endTime = currentSessionEndTime {
                        Spacer().frame(width: Date() < endTime ? ((geo.size.width * progress / 100) - 30) : geo.size.width)
                    }
                    if let startTime = currentSessionStartTime {
                        if let endTime = currentSessionEndTime {
                            if endTime > Date() {
                                Text("\(abs(Date().timeIntervalSince(startTime)).secondsToHoursMinsSecs())")
                            } else {
                                Text((endTime.timeIntervalSince(startTime)).secondsToHoursMinsSecs())
                            }
                        }
                        

                    } else {
                        Text("")
                    }
                    Spacer()
                    if progress < 93 {
                        if let startTime = currentSessionStartTime, let endTime = currentSessionEndTime {
                            Text((endTime.timeIntervalSince(startTime)).secondsToHoursMinsSecs())
                        } else {
                            Text("")
                        }
                        
                    }
                }
                .font(.caption2)
                ZStack {
                    HStack {
                        Rectangle()
                            .frame(width: geo.size.width, height: 10)
                            .foregroundColor(.secondary)
                            .cornerRadius(16)
                    }
                    HStack {
                        if let endTime = currentSessionEndTime {
                            Rectangle()
                                .frame(width: Date() < endTime ? geo.size.width * progress / 100 : geo.size.width, height: 10 )
                                .foregroundColor(barColor)
                                .cornerRadius(16)
                            Spacer()
                        }
                        
                    }
                }
            }
        }
        .frame(height: 10)
        .padding()
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView(currentSessionType: .constant(.regularSession), currentSessionStartTime: .constant(Date().addingTimeInterval(-400)), currentSessionEndTime: .constant(Date().addingTimeInterval(100)))
    }
}




