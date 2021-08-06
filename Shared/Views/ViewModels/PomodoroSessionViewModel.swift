//
//  PomodoroSessionViewModel.swift
//  PomodoroSessionViewModel
//
//  Created by Aidan Pendlebury on 02/08/2021.
//

import Foundation

enum SessionType {
    case regularSession
    case shortBreak
    case longBreak
}

class PomodoroSessionViewModel: ObservableObject {
    
    @Published var isActive = false
    @Published var startTime: Date?
    @Published var sessionLength: Double = 0
    @Published var numberOfPomos: Int = 3
    @Published var currentSessionType: SessionType = .regularSession
    var sessionCounter = 0

    var counter: Double {
        guard isActive else { return 0 }
        
        return startTime!.secondsSinceDate()
    }
    
    
    func startNewSession() {
        sessionCounter = 1
        startTime = Date()
        currentSessionType = .regularSession
        isActive = true
    }
    
    
    func stopSession() {
        isActive = false
        startTime = nil
        sessionLength = 0
        currentSessionType = .regularSession
        sessionCounter = 0
    }
    
    
    func rollSession() {
        switch currentSessionType {
        case .regularSession:
            if sessionCounter % numberOfPomos == 0 {
                currentSessionType = .longBreak
            } else {
                currentSessionType = .shortBreak
            }
        default:
            currentSessionType = .regularSession
        }
        startTime = Date()
        sessionCounter += 1
    }
    
}


