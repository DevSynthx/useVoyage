//
//  project_zApp.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import SwiftUI

@main
struct project_zApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
