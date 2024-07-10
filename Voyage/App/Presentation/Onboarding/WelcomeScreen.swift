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
    @State var newValueOffset: CGFloat = -0
    @State private var offset : CGFloat = 40
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
                                                Image("windowBorder")
                                                //.aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                                .scaleEffect(imageScrollToIndex == 2 ? 1.55 : 1.1)
                                                    .offset(y:  imageScrollToIndex == 2 ? 60 : -60)
                                            DragView(offset: $offsetx)
                                                .scaleEffect(imageScrollToIndex == 2 ? 1 : 0.7)
                                                .offset(y:  imageScrollToIndex == 2 ? 50 : -60)
                                                    .zIndex(1)
                                                    .onChange(of: offsetx) { oldValue, newValue in
                                                        self.newValueOffset = newValue
                                                        print("new value: \(newValue)")
                                                    }

                                                Image("sideSeat")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .offset(x: imageScrollToIndex == 2 ? 380 : 50, y: 35)
                                                  
                                            }
                                            .background(.onBoardingBG)
                                            .id(v)
                                        }
                                        Image("OnboardingA")
                                            .id(v)
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
                    
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: 20.0,
                        topTrailing: 20.0),
                        style: .continuous)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: geo.size.height / 3.8)
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
                                HStack {
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
                                Gap(h: 20)
                            }
                            .padding(.top, 30)
                        
                        }
                }
                if (-400 ... -200).contains(newValueOffset) {
                    AuthView()
                }
            }
           
           
        }
        .edgesIgnoringSafeArea(.all)

    
    }
    
    private func incrementIndex() {
           scrollToIndex = scrollToIndex == 3 ? 1 : scrollToIndex + 1
       // imageScrollToIndex += 1
        if imageScrollToIndex == 1 && scrollToIndex == 3 {
            imageScrollToIndex = 2
            offsetx = -30
              }
        else if scrollToIndex == 1 {
            print("herer")
            imageScrollToIndex = 0
            offsetx =  -370
        }
        else{
                  imageScrollToIndex += 1
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




