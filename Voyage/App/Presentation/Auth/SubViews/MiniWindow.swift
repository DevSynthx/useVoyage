//
//  MiniWindow.swift
//  project-z
//
//  Created by Inyene Etoedia on 09/06/2024.
//

import SwiftUI

struct MiniWindow: View {
    let midWindow: String
    let title: String
    let logo: String
    var openWindow: Bool = false
   // @State var openWindow: Bool = false
    var body: some View {
      
            ZStack{
                Image("mini_window_bg")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .gray.opacity(0.1),  radius: 8.9)
                Image("window_bg")
                   // .scaledToFit()
                Image(midWindow)
                    //.scaledToFit()
                Image("mini_sheet")
                    //.scaledToFit()
                    .offset(y: openWindow ? -200 : -35)
                    .animation(.interactiveSpring(duration: 1, blendDuration: 0.7), value: openWindow)
                    .mask {
                        Image(midWindow)
                           // .scaledToFit()
                    }
                VStack(alignment: .leading){
                    Image(logo)
                    Text(title)
                        .font(.custom(.medium, size: 14))
                        .foregroundStyle(.white)
                        .frame(height: 130, alignment: .top)
                }
            }
    }
}

#Preview {
    MiniWindow( midWindow: "google_mid_window", title: "Continue\nwith Google", logo: "apple_logo")
}
