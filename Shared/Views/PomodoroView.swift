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
    
    var progress: CGFloat {
        guard let startTime = currentSessionStartTime else { return 0 }
        guard let endTime = currentSessionEndTime else { return  0 }
        if Date() < endTime {
            return (abs(startTime.secondsSinceDate()) / endTime.timeIntervalSince(startTime))
        }
        return 1.0
        
    }
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                HStack {
                    Spacer()
                        .frame(maxWidth: geo.size.width * progress >= 30 ? geo.size.width * progress - 30 : 0)
                        .background(Color.red)
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
                    if progress < 0.93 {
                        if let startTime = currentSessionStartTime, let endTime = currentSessionEndTime {
                            Text((endTime.timeIntervalSince(startTime)).secondsToHoursMinsSecs())
                        } else {
                            Text("")
                        }
                    }
                }
                .font(.caption2)
                ProgressView(value: progress)
                    .frame(maxWidth: geo.size.width)
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



