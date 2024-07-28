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
        VStack(alignment: .leading){
            HStack {
                Text("Hi \(name)")
                    .font(.customx(.bold, size: 30))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Text("👋,")
                    .font(.customx(.bold, size: 30))
            }
            Gap(h: 14)
            Text("You can change your name\nif you like or proceed.")
                .font(.customx(.regular, size: 12))
                .foregroundStyle(.white)
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)
           
         
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
       
    }
}

#Preview {
    DisplayNameView(name: .constant("David"))
        .background(.black)
}
