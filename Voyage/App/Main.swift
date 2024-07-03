//
//  Main.swift
//  project-z
//
//  Created by Inyene Etoedia on 22/06/2024.
//

import SwiftUI

struct Main: View {
    @ObservedObject
    var router = Router<Routes>(root: .AuthView)
    var body: some View {
        RouterView(router: router) { path in
            switch path {
                case .AuthView: AuthView()
                case .PersonalityView:
                    PersonalityView()
                case .ComplimentView:
                    ComplimentView()
                case .InterestView:
                    InterestView()
                case .CityVisited:
                    CityVisited()
                case .TripType:
                    TripTypeView()
                case .BudgetType:
                    BudgetView()
            }
        }
        
    }
}

#Preview {
    Main()
        .environmentObject(Router(root: Routes.AuthView))
        .environmentObject(PersonalInfoVM())
}
