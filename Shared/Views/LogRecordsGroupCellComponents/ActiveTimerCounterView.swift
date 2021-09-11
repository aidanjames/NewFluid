//
//  ActiveTimerCounterView.swift
//  ActiveTimerCounterView
//
//  Created by Aidan Pendlebury on 04/09/2021.
//

import SwiftUI

struct ActiveTimerCounterView: View {
    
    var startTime: Date
    @EnvironmentObject var timer: TimerManager
    
    var body: some View {
        Text("\(startTime.secondsSinceDate().secondsToHoursMinsSecs())")
            .font(Font.system(.body).monospacedDigit())
    }
}

struct ActiveTimerCounterView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTimerCounterView(startTime: Date().addingTimeInterval(-6000))
    }
}
