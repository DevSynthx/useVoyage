//
//  SwiftUIView.swift
//  project-z
//
//  Created by Inyene Etoedia on 22/06/2024.
//

import SwiftUI

public class AnyIdentifiable: Identifiable {
    public let destination: any Identifiable
    
    public init(destination: any Identifiable) {
        self.destination = destination
    }
}

/*

public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()
    @Published public var presentedSheet: AnyIdentifiable?
    
    public init() {}
    
    public func presentSheet(destination: any Identifiable) {
        presentedSheet = AnyIdentifiable(destination: destination)
    }
    
    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }
    
    public func navigateBack() {
        navPath.removeLast()
    }
    

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
*/






final class Router<T: Hashable>: ObservableObject {
    @Published var root: T
    @Published var paths: [T] = []
    @Published public var presentedSheet: AnyIdentifiable?
    
    init(root: T) {
        self.root = root
    }
    
    public func presentSheet(destination: any Identifiable) {
        presentedSheet = AnyIdentifiable(destination: destination)
    }

    func push(to path: T) {
        paths.append(path)
    }
    
    func popUntil(predicate: (T) -> Bool) {
        while let last = paths.last, !predicate(last) {
            paths.removeLast()
        }
    }
    
    func pop() {
        paths.removeLast()
    }

    func updateRoot(root: T) {
        self.root = root
    }

    func popToRoot() {
        paths.removeAll()
    }
}



struct RouterView<T: Hashable, Content: View>: View {
    
    @ObservedObject
    var router: Router<T>
    
    @ViewBuilder var buildView: (T) -> Content
    var body: some View {
        NavigationStack(path: $router.paths) {
            buildView(router.root)
            .navigationDestination(for: T.self) { path in
                buildView(path)
            }
        }
        .environmentObject(router)
    }
}

enum Routes {
    case AuthView
    case PersonalityView
    case InterestView
    case CityVisited
    case TripType
    case BudgetType
}
 

