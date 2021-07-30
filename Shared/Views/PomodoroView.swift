//
//  PomodoroView.swift
//  PomodoroView
//
//  Created by Aidan Pendlebury on 29/07/2021.
//

import SwiftUI

struct PomodoroView: View {
    
    @Binding var progress: Double
    @Binding var sessionType: SessionType
    
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
    
    var body: some View {
        
        GeometryReader { geo in
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
        .frame(height: 10)
        .padding()
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView(progress: .constant(84), sessionType: .constant(.regularSession))
    }
}

enum SessionType {
    case regularSession
    case shortBreak
    case longBreak
}
