//
//  ghibli_dummy_appApp.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//

import SwiftUI
import CoreData

@main
struct ghibli_dummy_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
