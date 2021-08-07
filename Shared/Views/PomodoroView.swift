//
//  PomodoroView.swift
//  PomodoroView
//
//  Created by Aidan Pendlebury on 29/07/2021.
//

import SwiftUI

struct PomodoroView: View {
    
    @Binding var sessionType: SessionType
    @Binding var currentCounter: Double // Seconds into session
    @Binding var sessionLength: Double // Total seconds for session
    
    var barColor: Color {
        switch sessionType {
        case .regularSession:
            return .red
        case .shortBreak:
            return .green
        case .longBreak:
            return .blue
        }
    }
    
    var progress: Double { (currentCounter / sessionLength) * 100 }
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                HStack {
                    Spacer().frame(width: (geo.size.width * progress / 100) - 30)
                    Text(currentCounter.secondsToHoursMinsSecs())
                    Spacer()
                    if progress < 93 {
                        Text(sessionLength.secondsToHoursMinsSecs())
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
        PomodoroView(sessionType: .constant(.regularSession), currentCounter: .constant(13), sessionLength: .constant(30))
    }
}




