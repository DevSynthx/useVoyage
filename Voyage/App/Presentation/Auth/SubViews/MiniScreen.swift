//
//  MiniScreen.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/06/2024.
//


enum ContinueState {
    case start
    case continuex
    case done
}

import SwiftUI

struct MiniScreen: View {
    @EnvironmentObject var router: Router<Routes>
    var height : CGFloat
    var width : CGFloat
    @State var text: String = "David"
    @State var isContinue: Bool = false
    @State var isDone: Bool = false
    @State var formState: ContinueState = .start
    @Binding var username: String
    var body: some View {
        
        ZStack{
            Rectangle()
                .cornerRadius(20)
                .frame(width: width / 1.1, height: height / 3)
                .foregroundStyle(.black)
                .overlay{
                    Image("screen_buttons")
                         .resizable()
                         .scaledToFit()
                         .frame(maxHeight: .infinity, alignment: .bottom)
                         .padding(.horizontal, 22)
                         .padding(.bottom, 7)
                }
                

            Rectangle()
                .fill(LinearGradient(
                                   gradient: Gradient(colors: [Color(hex: "FF87C7"), Color(hex: "48ACF0")]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
                .cornerRadius(15)
                .frame(width: width / 1.3, height: height / 3.9)
                .overlay{
                    VStack {
                        switch formState {
                            case .start:
                                WelcomeView()
                            case .continuex:
                                EnterNameView(username: $username)
                            case .done:
                                DisplayNameView(name: $username)
                        }
                        
                       Spacer()
                        if(formState != .done){
                            AppButton(action:{
                              
                                withAnimation {
                                    switch formState {
                                        case .start:
                                            self.formState = .continuex
                                        case .continuex:
                                            guard !username.isEmpty else {
                                                print("Error")
                                                return
                                            }
                                            self.formState = .done
                                        case .done:
                                            self.formState = .continuex
                                    }
                                  
                                }
                            })
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottomTrailing)
                            .padding(.trailing, 10)
                        }
                        else {
                            HStack(alignment: .center){
                                AppButton(action:{
                                    withAnimation {
                                        self.formState = .continuex
                                    }
                                },
                                title: "Edit Name",
                                textColor: .white,
                                bgColor: .black
                                )
                                Spacer()
                                AppButton(action:{
                                    router.push(to: .PersonalityView)
                                },
                                title: "Get Started"
                                )
 
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal, 20)
                        }
                        
                        Gap(h: 10)
                    }
                  
                
                }
            
        }
    }
}

#Preview {
    GeometryReader { geo in
        MiniScreen(height: geo.size.height, width: geo.size.width, username: .constant("David"))
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)

    }
}
