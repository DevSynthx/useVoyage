//
//  OnBoardingView.swift
//  Voyage
//
//  Created by Inyene Etoedia on 15/07/2024.
//

import SwiftUI

struct OnBoardingView: View {
    var screenHeight: CGFloat = 100
    var handHeight: CGFloat = 250
    var body: some View {
       
            ZStack (alignment: .top) {
                Image("backseat")
                      .resizable()
                      .offset(y: -55)
                Image("screenView")
                    .offset(y: screenHeight)
                Image("onBoardHand")
                    .offset(y: handHeight)

            }

            .ignoresSafeArea()
        
      
    }
}

#Preview {
    OnBoardingView()
}
