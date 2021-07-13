//
//  Int+Ext.swift
//  NewFluid (iOS)
//
//  Created by Aidan Pendlebury on 13/07/2021.
//

import Foundation

extension Int {
    
    func secondsToHoursMinsSecs() -> String {
        let hours = self / 3600
        let mins = (self % 3600) / 60
        let secs = (self % 3600) % 60
        
        return hours < 1 ? String(format: "%01d:%02d", mins, secs) : String(format: "%01d:%02d:%02d", hours, mins, secs)
    }
    
}
