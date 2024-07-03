//
//  project_zApp.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import SwiftUI

@main
struct Voyage: App {
//    init(){
//        setupServiceContainer()
//    }
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Main()
               .environmentObject(PersonalInfoVM())
               .environmentObject(LocationManagerVM())
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


private extension  Voyage {
    
    func setupServiceContainer() {
        // Services
        ServiceContainer.register(type: URLSession.self, .shared)
        ServiceContainer.register(type: HTTPService.self, NetworkService())
        ServiceContainer.register(type: TestRepository.self, TestService())
    
    }
}
