//
//  NewFluidApp.swift
//  Shared
//
//  Created by Aidan Pendlebury on 25/06/2021.
//

import SwiftUI

@main
struct NewFluidApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
