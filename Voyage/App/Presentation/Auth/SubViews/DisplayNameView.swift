//
//  DisplayNameView.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/06/2024.
//

import SwiftUI

struct DisplayNameView: View {
    @Binding var name: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Gap(h: 10)
            Text("Hi \(name.truncate(7)) 👋")
                .font(.custom(.bold, size: 30))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
            Text("You can change your name\nif you like or proceed.")
                .font(.custom(.regular, size: 12))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)
           
         
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    DisplayNameView(name: .constant("David"))
        .background(.black)
}
