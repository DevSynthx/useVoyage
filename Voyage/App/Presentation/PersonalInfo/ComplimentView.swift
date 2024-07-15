//
//  ComplimentView.swift
//  Voyage
//
//  Created by Inyene Etoedia on 03/07/2024.
//

import SwiftUI

struct ComplimentView: View {
    @Environment(\.router) var router
    var body: some View {
        VStack{
            Image("handShake")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size / 3
                }
            Gap(h: 50)
            Text("You have\nnice taste!")
                .multilineTextAlignment(.center)
                .font(.custom(.bold, size: 40))
                .foregroundStyle(.black)
                .padding(.leading, 20)
            Gap(h: 20)
            Text("You are almost done, Let's know\nwhat you are interested in")
                .lineSpacing(5)
                .multilineTextAlignment(.center)
                .font(.custom(.light, size: 16))
                .foregroundStyle(.black)
                .padding(.leading, 20)
            
            Gap(h: 70)

            NextButton {
                router?.push(to: .InterestView)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ComplimentView()
        .environmentObject(Router(root: Routes.InterestView))
}


struct NextButton: View {
    var color: Color = .black
    let action: ()->Void
    var body: some View {
        Image(systemName: "arrow.right")
            .font(.system(size: 20))
            .foregroundStyle(.white)
            .padding(13)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(color)
            }
            .onTapGesture(perform: action)
    }
}
