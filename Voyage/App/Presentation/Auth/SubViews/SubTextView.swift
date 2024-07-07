//
//  SubTextView.swift
//  project-z
//
//  Created by Inyene Etoedia on 11/06/2024.
//

import SwiftUI

struct SubTextView: View {
    var backArrowOffset : CGFloat = 0
    var forwardArrowOffset : CGFloat = 0
    var scaleOpacity: CGFloat = 0
    var scaleText : CGFloat = 0
    var textOffset : CGFloat = 0
    var textOpacity: CGFloat = 0
    var opacity : CGFloat = 0
    var body: some View {
        VStack(spacing: 0){

            HStack(alignment: .center, spacing: 40) {
                Image("arrow_right")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 20)
                    .rotationEffect(.degrees(180))
                    .opacity(opacity)
                    .offset(x: backArrowOffset)
                Text("SWIPE")
                    .font(.custom(.regular, size: 12))
                    .foregroundStyle(.black)
                    .kerning(5)
                    .scaleEffect(scaleText)
                    .opacity(scaleOpacity)
                Image("arrow_right")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 20)
                    .opacity(opacity)
                    .offset(x: forwardArrowOffset)
            }
           Gap(h: 70)
            Text("Exploring meets\naccurate planning")
                .font(.custom(.regular, size: 30))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .opacity(textOpacity)
                .offset(y:textOffset)
        }
    }
}

#Preview {
    SubTextView()
}
