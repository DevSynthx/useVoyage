//
//  Profilescreen.swift
//  Voyage
//
//  Created by Inyene Etoedia on 08/07/2024.
//

import SwiftUI

struct ProfileView: View {
    @State var circleOffset: CGFloat = 10.0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading){
            Gap(h: 30)
            HStack(alignment: .top){
                Text("Go back")
                    .font(.customx(.bold, size: 16))
                    .foregroundStyle(.black)
                Image("return")
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 9)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.passportText,  lineWidth: 2)
            }
            .onTapGesture {
                dismiss()
            }
            Gap(h: 60)
            Text("Profile")
                .font(.customx(.bold, size: 28))
                .padding(.bottom, 5)
                .foregroundStyle(.black)
            Text("Manage your profile information")
                .font(.customx(.light, size: 14))
                .padding(.bottom, 5)
                .foregroundStyle(.black.opacity(0.5))
            Gap(h: 50)
            Text("PROFILE")
                .font(.customx(.regular, size: 16))
                .padding(.bottom, 5)
                .foregroundStyle(.black.opacity(0.5))
            VStack(alignment: .leading){
                ForEach(Array(Profile.profilex.indices), id: \.self) { v in
                    if v != 0 {
                               Divider()
                           }
                    HStack{
                        VStack(alignment: .leading){
                            Text(Profile.profilex[v].username)
                                .font(.customx(.bold, size: 16))
                                .padding(.bottom, 5)
                                .foregroundStyle(.black)
                            if v == 0 {
                                Text("\("richmond123@email.com")")
                                    .font(.customx(.light, size: 14))
                                    .padding(.bottom, 5)
                                    .foregroundStyle(.black)
                            }
                        }
                       
                        Spacer()
                        if v == 0 {
                            Text("Update")
                                .font(.customx(.medium, size: 15))
                                .padding(.bottom, 5)
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 15))
                                .foregroundStyle(.black)
                        }
                      
                    }
                    .padding(.vertical, 17)
                   
                }
            }
            Text("NOTIFICATIONS")
                .font(.customx(.regular, size: 16))
                .padding(.bottom, 5)
                .foregroundStyle(.black.opacity(0.5))
            Gap(h: 30)
            HStack{
                Text("Get updates & tips")
                    .font(.customx(.bold, size: 16))
                    .padding(.bottom, 5)
                    .foregroundStyle(.black)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.shadow(.inner(color:.gray,  radius: 5, y: 0.3)))
                        .foregroundColor(.white)
                                       .frame(width: 60, height: 35)
                    Circle()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.gray)
                        .offset(x: circleOffset)
                        .gesture(
                         DragGesture()
                            .onChanged({ val in
                                if(val.startLocation.x > 15) {
                                    withAnimation {
                                        circleOffset = -10.0
                                    }
                                }
                                else {
                                    withAnimation {
                                        circleOffset = 10.0
                                    }
                                    
                                }
                            })
                         
                        )
                
                }
            }
            Gap(h: 50)
            Divider()
            Gap(h: 40)
            Text("Remove account")
                .font(.customx(.bold, size: 16))
                .padding(.bottom, 5)
                .foregroundStyle(.red)
        }
        .padding(.horizontal, 25)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , maxHeight: .infinity, alignment: .topLeading)
        .background(.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView()
}




struct Profile {
    var username:String
 
    
    static var profilex: [Profile] = [
        Profile(username: "Richmond"),
        Profile(username: "Personality"),
        Profile(username: "Interests")
    ]
}
