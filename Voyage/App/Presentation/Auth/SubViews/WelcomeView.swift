//
//  WelcomeView.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/06/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack (alignment: .top){
                Text("Welcome\nto Voyage")
                    .font(.customx(.bold, size: 30))
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .alignmentGuide(.top, computeValue: { dimension in
                        dimension.height / 9
                    })
                Spacer()
               Image("plane_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
          
            Text("Experience the world like never before,\nwith tailored recommendations made for\nthe best you")
                .font(.customx(.regular, size: 12))
                .lineSpacing(4)
                .foregroundStyle(.white)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading, 15)
        .padding(.trailing, 10)
    }
}

#Preview {
    WelcomeView()
        .background(.black)
}
