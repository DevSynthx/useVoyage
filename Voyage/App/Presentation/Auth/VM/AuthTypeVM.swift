//
//  AuthTypeVM.swift
//  project-z
//
//  Created by Inyene Etoedia on 09/06/2024.
//

import Foundation

class AuthTypeVM: ObservableObject {
    
    @Published var auths =  [AuthType]()
    
    init(){
        authTypes()
    }
    
    func authTypes(){
        let types = [
            AuthType(window: "google_mid_window", title: "Continue\nwith Google", logo: "google_logo", isOpen: false),
            AuthType(window: "apple_mid_window", title: "Continue\nwith Apple", logo: "apple_logo", isOpen: true),
            AuthType(window: "get_started_mid_window", title: "Get Started", logo: "arrow", isOpen: false)
        ]
        
        auths.append(contentsOf: types)
    }
    
    func updateIsOpen(window: String) {
        _ = auths.indices.map{auths[$0].isOpen = auths[$0].window == window}
    }
    
    
}
extension AuthType {
    static func model() -> AuthType {
        return  AuthType(window: "get_started_mid_window", title: "Get Started", logo: "arrow", isOpen: false)
    }
}



struct AuthType{
    var window: String
    var title: String
    var logo: String
    var isOpen: Bool
}



