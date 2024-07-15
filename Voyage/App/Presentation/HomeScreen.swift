//
//  HomeScreen.swift
//  Voyage
//
//  Created by Inyene Etoedia on 08/07/2024.
//

import SwiftUI

struct HomeScreen: View {
    let size = UIScreen.main.bounds.size
    @Environment(\.router) var router
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                Rectangle()
                    .foregroundStyle(.lightYellow)
                    .padding(.horizontal, 20)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
                Rectangle()
                    .foregroundStyle(.black)
                    .padding(.horizontal, 20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 75)
            .padding(.top, 72)
            
            VStack(spacing: 0){
                // Check our your previous trips and relieve great memories.
                HStack {
                    Image("plane")
                    Gap(w: 20)
                    VStack(alignment: .leading){
                        Text("SAVED LOCATIONS")
                            .font(.custom(.bold, size: 16))
                            .lineSpacing(3)
                            .foregroundStyle(.black)
                        Gap(h: 10)
                        Text("Check our your previous trips\nand relieve great memories.")
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .font(.custom(.light, size: 12))
                            .lineSpacing(3)
                            .foregroundStyle(.black)
                    }
                    Gap(w: 25)
                    Image("profileIcon")
                        .onTapGesture {
                            router?.push(to: .ProfileScreen)
                        }
                }
                .padding(.vertical, 20.4)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background{
                    Rectangle()
                        .foregroundStyle(.yellowCard)
                    
                }
                .padding(.horizontal, 20)
                
                Rectangle()
                    .foregroundStyle(.deepGray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .top){
                        VStack(alignment:.leading){
                         
                            Gap(h: 20)
                            ForEach(0..<3) { v in
                                if v != 0 {
                                           Divider()
                                       }
                                    HStack{
                                        Image("imageIcon")
                                            .font(.custom(.light, size: 13))
                                      Gap(w: 20)
                                        Text("Las Vegas Nevada, USA")
                                            .font(.custom(.light, size: 14))
                                            .foregroundStyle(.white)
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .font(.custom(.light, size: 13))
                                            .foregroundStyle(.white)
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 15)
                                if v == 2{
                                    Divider()
                                }
                                
                                }
                           Spacer()
                            VStack(alignment:.leading){
                                Text("Ready for your next vacation?")
                                    .font(.custom(.bold, size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 5)
                                Text("Need new locations for your next trip? We got you")
                                    .font(.custom(.light, size: 12))
                                    .foregroundStyle(.white)
                                    
                                Gap(h: 25)
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    HStack{
                                      Text("Get recommendations")
                                            .font(.custom(.bold, size: 14))
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Image("star")
                                    }
                                    .padding(.vertical, 6)
                                })
                                .buttonStyle(.borderedProminent)
                                .accentColor(.white)
                            }
                            .padding(.horizontal, 20)
                            
                            Gap(h: 40)
                            }
                        }
                    .padding(.horizontal, 20)
                        
                    }
                    .padding(.bottom, 75)
                    .padding(.top, 78)
                    .padding(.leading, 15)
            }
            .background{
                Image("homeBG")
                    .resizable()
            }
            .ignoresSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            
        }
        
    }
    

#Preview {
    HomeScreen()
        .environmentObject(Router(root: Routes.ProfileScreen))
}
