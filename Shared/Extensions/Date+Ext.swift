//
//  Date+Ext.swift
//  NewFluid (iOS)
//
//  Created by Aidan Pendlebury on 09/07/2021.
//

import Foundation

extension Date {
    
    func difference() -> String {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: self, to: Date())
        let hours = diffComponents.hour
        let minutes = diffComponents.minute
        let seconds = diffComponents.second
        
        return "\(hours ?? 0): \(minutes ?? 0): \(seconds ?? 0)"
        
    }
    
    
    
}
