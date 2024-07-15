//
//  WelcomeScreen.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/03/2024.
//

import SwiftUI

struct WelcomeScreen: View {
    @State private var bottomSheetShown = false
    @State private var scrollToIndex: Int = 1
    @State private var imageScrollToIndex: Int = 0
    @GestureState private var translation: CGFloat = 0
    @State private var widths: [CGFloat] = [90, 30, 30]
    @State var offsetx: CGFloat = -370
    @State private var offset : CGFloat = 40
    @State private var scalefx : CGFloat = 0.7
    @State private var valueChanged: Bool = false
    @State private var value: Bool = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ZStack(alignment: .bottom){
                    ZStack{
                        ScrollView(.horizontal) {
                            ScrollViewReader(content: { proxy in
                                HStack {
                                    ForEach(0..<2) { v in
                                        if(v == 1){
                                        ZStack(alignment: .top){
                                                Image("windowBorder 1")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .containerRelativeFrame(.horizontal, { size, _ in
                                                    size
                                                })
                                                .scaleEffect(imageScrollToIndex == 2 ? 1.65 : 1.1)
                                                    .offset(y:  imageScrollToIndex == 2 ? -20 : -105)
                                            DragView(offset: $offsetx, value: $value)
                                                .scaleEffect(scalefx)
                                                .offset(y:  imageScrollToIndex == 2 ? 10 : -80)
                                                    .zIndex(scalefx == 1 ? 1 : 0)
                                                    .onChange(of: value, { oldValue, newValue in
                                                        valueChanged = newValue
                                                        print("new_value: \(newValue)")
                                                    })
                                                    .disabled(scalefx == 1 ? false : true)

                                                Image("sideSeat")
                                                    .aspectRatio(contentMode: .fit)
                                                    .offset(x: imageScrollToIndex == 2 ? 380 : 70, y: 60)
                                                  
                                            }
                                            .id(v)
                                        }
                                        OnBoardingView(screenHeight: geo.size.height / 7.5, handHeight: geo.size.height / 3.1)
                                            .id(v)
//                                        Image("OnboardingA")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .id(v)
                                    }
                                    .onChange(of: imageScrollToIndex) { oldValue, newValue in
                                        withAnimation {
                                        proxy.scrollTo(newValue)
                                        }
                                    }
                                }
                                .scrollTargetLayout()
                            })
                           
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .scrollDisabled(true)


                       }
                     .background(.onBoardingBG)
                  
                    
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: 20.0,
                        topTrailing: 20.0),
                        style: .continuous)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: geo.size.height / 3.5)
                        .foregroundStyle(.white)
                        .overlay(alignment: .topLeading){
                            
                            VStack(alignment: .leading){
                                Gap(h: 10)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    ScrollViewReader(content: { proxy in
                                        HStack{
                                            ForEach(OnBoardingModel.onBoardingList.enumerated().map{$0}, id: \.element.id) { v in
                                                VStack(alignment: .leading){
                                                    Text(v.element.title)
                                                        .font(.custom(.bold, size: 25))
                                                        .lineSpacing(3)
                                                        .padding(.bottom, 10)
                                                        .foregroundStyle(.black)
                                                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                                    Text(v.element.subtitle)
                                                        .font(.custom(.light, size: 15))
                                                        .lineSpacing(3)
                                                        .padding(.bottom, 5)
                                                        .foregroundStyle(.black)
                                                }
                                                .padding(.leading, 30)
                                                .frame(width: 400, alignment: .leading)
                                                .id(v.offset)
                                            }
                                            .onChange(of: scrollToIndex) { oldValue, newValue in
                                                withAnimation {
                                                proxy.scrollTo(newValue)
                                                }
                                            }
                                        }
                                        .scrollTargetLayout()
                                    })
                                }
                                .scrollTargetBehavior(.viewAligned)
                                .scrollDisabled(true)
                                
                                Spacer()
                                HStack(alignment: .bottom) {
                                    HStack{
                                        ForEach(Array(widths.indices), id: \.self) { v in
                                           RoundedRectangle(cornerRadius: 20)
                                                .foregroundStyle( widths[v] == 90 ? .darkBlue : .gray)
                                                .frame(width: widths[v],height: 5)
                                        }
                                    }
                                    Spacer()
                                    NextButton(color: .black) {
                                        withAnimation {
                                            incrementIndex()
                                        }
                                    }
                                }
                                .padding(.horizontal, 30)
                                Gap(h: 30)
                            }
                            .padding(.top, 30)
                        
                        }
                }
                .ignoresSafeArea(.all)
                if valueChanged {
                    AuthView()
                }
            }
        }
        //.ignoresSafeArea(.all)

    
    }
    
    private func incrementIndex() {
           scrollToIndex = scrollToIndex == 3 ? 1 : scrollToIndex + 1
       // imageScrollToIndex += 1
    
       
        if scrollToIndex == 1 {
            scalefx = 0.7
        }
        if imageScrollToIndex == 1 && scrollToIndex == 3 {
            imageScrollToIndex = 2
            offsetx = 0
           
            scalefx = 1
              }
        else if scrollToIndex == 1 {
            print("herer")
            imageScrollToIndex = 0
            offsetx =  -370
        }
        else{
            imageScrollToIndex += 1
            scalefx = 0.7
        }
        updateWidths(for: scrollToIndex)
       }

    
    private func updateWidths(for newIndex: Int) {
            // Reset all widths to the initial value
       
        widths = Array(repeating: 30, count: widths.count)
            
            // Update the width of the new index
        widths[ newIndex - 1] = 90 // Increase width for the new index
            
            // Update scrollToIndex
           scrollToIndex = newIndex
        }
    
    private func rectWidth() -> CGFloat {
        switch scrollToIndex {
            case 1:
                60
            case 2:
                60
            case 3:
                60
            default:
                40
        }
    }
}

#Preview {
    WelcomeScreen()
}

struct OnBoardingModel: Hashable{
    var id: Int
    var title: String
    var subtitle: String
    
    static var onBoardingList: [OnBoardingModel] = [
    
       OnBoardingModel(id: 1, title: "Discover your next\ndestination", subtitle: "Experience the world like never before."),
       OnBoardingModel(id: 2, title: "Get AI recommendations\nwhile you relax", subtitle: "Experience the world like never before."),
       OnBoardingModel(id: 3, title: "Choose your next adventure.\nSave some for the future", subtitle: "Experience the world like never before.")
    
    ]
}




