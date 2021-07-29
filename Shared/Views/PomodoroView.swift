//
//  PomodoroView.swift
//  PomodoroView
//
//  Created by Aidan Pendlebury on 29/07/2021.
//

import SwiftUI

struct PomodoroView: View {
    
    @State private var progress: Double = 80
    
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
                    Spacer()
                    Rectangle()
                        .frame(width: geo.size.width * (100 - progress) / 100, height: 10)
                        .foregroundColor(.green)
                        .cornerRadius(16)
                }
            }
        }
        .frame(height: 10)
        .padding()
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
