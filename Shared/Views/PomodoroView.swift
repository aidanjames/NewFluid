//
//  PomodoroView.swift
//  PomodoroView
//
//  Created by Aidan Pendlebury on 29/07/2021.
//

import SwiftUI

struct PomodoroView: View {
    
    @Binding var currentSessionType: SessionType
    @Binding var currentSessionStartTime: Date
    @Binding var currentSessionEndTime: Date
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
    
    var progress: Double { (abs(currentSessionStartTime.secondsSinceDate()) / currentSessionEndTime.timeIntervalSince(currentSessionStartTime)) * 100 }
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                HStack {
                    Spacer().frame(width: (geo.size.width * progress / 100) - 30)
                    Text("\(abs(Date().timeIntervalSince(currentSessionStartTime)).secondsToHoursMinsSecs())")
                    Spacer()
                    if progress < 93 {
                        Text((currentSessionEndTime.timeIntervalSince(currentSessionStartTime)).secondsToHoursMinsSecs())
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
                        Rectangle()
                            .frame(width: geo.size.width * progress / 100, height: 10)
                            .foregroundColor(barColor)
                            .cornerRadius(16)
                        Spacer()
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




