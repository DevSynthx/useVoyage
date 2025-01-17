//
//  Main.swift
//  project-z
//
//  Created by Inyene Etoedia on 22/06/2024.
//

import SwiftUI

struct Main: View {
    @ObservedObject
    var router = Router<Routes>(root: .onBoardingView)
    var body: some View {
        RouterView(router: router) { path in
            switch path {
                case .onBoardingView:
                    WelcomeScreen()
                case .HomeScreen: HomeScreen()
                case .ProfileScreen: ProfileView()
                case .AuthView: AuthView()
                case .GetStartedView:
                    GetStartedView()
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
                case .ChooseSeasonView:
                    ChooseSeasonView()
            }
        }
        .environment(\.router, router)
    }
}

#Preview {
    Main()
        .environmentObject(PersonalInfoVM())
        .environmentObject(LocationManagerVM())
}
