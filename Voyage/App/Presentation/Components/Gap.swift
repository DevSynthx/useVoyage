//
//  Gap.swift
//  project-z
//
//  Created by Inyene Etoedia on 06/06/2024.
//

import SwiftUI

struct Gap: View {
    var h: CGFloat = 5
    var w: CGFloat = 5
    var body: some View {
        Spacer()
            .frame(width: w, height: h)
    }
}


struct SwipeView: View {
    var color: Color = .black
    var body: some View {
        HStack(alignment: .center, spacing: 40) {
            Image("arrow_right")
                .resizable()
                .foregroundStyle(color)
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(180))
            
            Text("SWIPE")
                .font(.custom(.regular, size: 14))
                .foregroundStyle(color)
                .kerning(5)
            Image("arrow_right")
                .resizable()
                .foregroundStyle(color)
                .frame(width: 20, height: 20)
        }
    }
}
