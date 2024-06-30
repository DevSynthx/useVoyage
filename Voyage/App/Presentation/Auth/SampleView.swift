//
//  SampleView.swift
//  project-z
//
//  Created by Inyene Etoedia on 09/06/2024.
//

import SwiftUI

struct SampleView: View {
    @Namespace private var nameSpace
    @Namespace private var nameSpacex
    @StateObject private var authTypeVm = AuthTypeVM()
    @State private var show: Bool = false
    var list : [String] = [
        "water",
        "drink",
        "cow"
    ]
    @State private var selected: String = ""
    var body: some View {

            ZStack (alignment: .center ){
                GeometryReader(content: { geo in
                    let size = geo.size
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack(spacing: 20){
                            ForEach(authTypeVm.auths.enumerated().map { $0 }, id: \.element.title) { index, auth in
                                HStack {
                                    ZStack{
                                       
                                        Image("mini_window_bg")
                                            .resizable()
                                            .scaledToFit()
                                          Image("window_bg")
                                        Image(auth.window)
                                        Image("mini_sheet")
                                            .offset(y: auth.isOpen ? -200 : -35)
                                            .animation(.interactiveSpring(duration: 1, blendDuration: 0.7), value: auth.isOpen)
                                            .mask {
                                                Image(auth.window)
                                            }
                                        VStack(alignment: .leading){
                                            Image(auth.logo)
                                            Text(auth.title)
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundStyle(.white)
                                                .frame(height: 130, alignment: .top)
                                        }
                                    }
//                                    .zIndex(selected == auth.title ? 1 : 0)
                                    .matchedGeometryEffect(id: auth.title, in: nameSpace)
                                    .frame(width: 200, height: 300)
                                   // .scaledToFit()
                                    .onTapGesture {
                                        withAnimation {
                                            show = true
                                           selected = auth.title
                                        }
                                   
                                    }
        //                                     .frame(width: size.width - 200, height: size.height)
                                         .background(GeometryReader { itemGeo in
                                             Color.clear
                                                 .preference(key: ViewOffsetKey.self, value: [itemGeo.frame(in: .global).midX])
                                         })
                                         .scrollTransition(.interactive, axis: .horizontal){
                                        view, phase in
                                           
                                        view.scaleEffect(phase.isIdentity ? 1 : 0.85)
                                             
                                     }
                                }
                            }
                        }
                        .frame(height: size.height)
                        .scrollTargetLayout()
                        .padding(.vertical, 20)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .defaultScrollAnchor(.center)
                })
                   

                if show {
                    Rectangle()
                        .matchedGeometryEffect(id: selected, in: nameSpace)
                        .frame(width: 500, height: 700)
                }
//                Image("mini_window_bg")
//                    .shadow(color: .gray.opacity(0.2),  radius: 8.9)
//                Image("window_bg")
//                Image("google_mid_window")
//                Image("mini_sheet")
//                    .offset(y: -50)
//                    .mask {
//                        Image("google_mid_window")
//                    }
                
            }
            .background(.grey)
        
    }
}

#Preview {
    SampleView()
}
