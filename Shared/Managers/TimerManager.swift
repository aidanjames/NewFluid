//
//  TimerManager.swift
//  NewFluid (iOS)
//
//  Created by Aidan Pendlebury on 09/07/2021.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var ticker: Int = 0
    var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.ticker += 1
        }
    }
}

