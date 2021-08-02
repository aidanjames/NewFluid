//
//  PomodoroSessionViewModel.swift
//  PomodoroSessionViewModel
//
//  Created by Aidan Pendlebury on 02/08/2021.
//

import Foundation

class PomodoroSessionViewModel: ObservableObject {
    
    @Published var isActive = false
    @Published var startTime: Date?
    @Published var sessionLength: Double = 0
    @Published var currentSessionType: SessionType = .regularSession

    var counter: Double {
        guard isActive else { return 0 }
        
        return startTime!.secondsSinceDate()
    }
    
}
