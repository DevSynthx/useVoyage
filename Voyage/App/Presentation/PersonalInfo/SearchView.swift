//
//  SearchView.swift
//  project-z
//
//  Created by Inyene Etoedia on 23/06/2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var vm : PersonalInfoVM
    let namespace: Namespace.ID
    @State var text : String = ""
    let action: ()->Void
    var body: some View {
        
        VStack {
            Gap(h: 20)
            HStack {
                TextField("Search city", text: $vm.searchText, prompt: Text("Search city").foregroundStyle(.gray))
                    .foregroundStyle(.black)
                    .frame(height: 40)
                    .padding(.horizontal, 10)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.horizontal], 4)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray))
                    .padding([.leading], 24)
                    .matchedGeometryEffect(id: "textfield", in: namespace, isSource: true)
                    //.animation(.spring, value: showSearch)
                   
                Button(action: action) {
                    Text("Cancel")
                        .font(.customx(.regular, size: 15))
                }
            
            }
            .padding(.trailing, 20)
            Gap(h: 25)
            
            ScrollView(showsIndicators: false) {
                ForEach(vm.filtercities, id: \.name) { v in
                    Text(v.name)
                        .font(.customx(.regular, size: 17))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            vm.selectedCity(city: v)
                            vm.searchText = ""
                            action()
                        }
                }
            }
        }
        .matchedGeometryEffect(id: "show", in: namespace, isSource: true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.white)
    }
}

#Preview {
    SearchView(namespace: Namespace().wrappedValue, action: {})
        .environmentObject(PersonalInfoVM())
}
