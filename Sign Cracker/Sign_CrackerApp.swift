//
//  Sign_CrackerApp.swift
//  Sign Cracker
//
//  Created by Corey Edh on 1/14/22.
//

import SwiftUI

@main
struct Sign_CrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


