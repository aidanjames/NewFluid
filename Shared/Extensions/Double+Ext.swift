//
//  Double+Ext.swift
//  NewFluid (iOS)
//
//  Created by Aidan Pendlebury on 09/07/2021.
//

import Foundation

extension Double {
    
    func secondsToHoursMinsSecs() -> String {
        let number = Int(self)
        let hours = number / 3600
        let mins = (number % 3600) / 60
        let secs = (number % 3600) % 60
        
        return hours < 1 ? String(format: "%01d:%02d", mins, secs) : String(format: "%01d:%02d:%02d", hours, mins, secs)
    }
    
}
