//
//  AuthView.swift
//  project-z
//
//  Created by Inyene Etoedia on 04/06/2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var authTypeVm = AuthTypeVM()
    @EnvironmentObject var location : LocationManagerVM
    @State private var animate = [false, false, false]
    @State private var backArrowOffset: CGFloat = 0.5
    @State private var forwardArrowOffset: CGFloat = -0.5
    @State private var textOffset: CGFloat = -5
    @State private var textOpacity: CGFloat = 0
    @State private var opacity: CGFloat = 0
    @State private var scaleText: CGFloat = 0
    @State private var scaleOpacity: CGFloat = 0
    @State private var appNameScale: CGFloat = 2
    @State private var appNameOpacity: CGFloat = 0
    @State private var openWindow: Bool = false
    
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0.0
    @State private var numberItems: CGFloat = 3
    @State private var peekView: CGFloat = 10
    @State private var dragThreshold: CGFloat = 50
    @State private var itemWidth: CGFloat = 300
    
    @State var isTapped = false
    @State var showView = false
    @State var currentItemX = AuthType(window: "get_started_mid_window", title: "Get Started", logo: "arrow", isOpen: false)
    @Namespace private var nameSpacexx
    @State private var bottomSheetShown = false
    let size = UIScreen.main.bounds.size
    let sizex = UIScreen.current?.bounds.size
    @State private var sizeOfCard: CGSize = .zero
    @State private var screenSize: CGSize = .zero
    /*
    init(){
        for familyName in UIFont.familyNames{
            print(familyName)
        }
    }
    */

    var body: some View {
        
        ZStack(alignment: .center) {
            
            if !isTapped{
                VStack{
                    Gap(h: 30)
                    Image("dot")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                    Spacer()
            
                    Text("Voyage")
                        .font(.custom(.bold, size: 50))
                        .foregroundStyle(.black)
                        .scaleEffect(appNameScale)
                        .opacity(appNameOpacity)
                        .transition(.scale)
                   
                    Gap(h: screenSize.height / 18)
                
                        ScrollView (.horizontal, showsIndicators: false){
                            HStack(spacing: 20){
                                ForEach(authTypeVm.auths.enumerated().map { $0 }, id: \.element.title) { index, auth in

                                    HStack(spacing: 0) {
                                            MiniWindow(midWindow: auth.window, title: auth.title, logo: auth.logo, openWindow: currentIndex == index ? true : false)
                                                .matchedGeometryEffect(id: auth.title, in: nameSpacexx, isSource: true)
                                                .matchedGeometryEffect(id: auth.logo, in: nameSpacexx, isSource: true)
                                                .opacity(animate[index] ? 1 : 0)
                                                .offset(x: xOffsetForIndex(index))
                                                .frame(width: 200, height: 300)
                                                .zIndex(auth.title == currentItemX.title ? 1 : 0)
                                                .scaleEffect(scaleForIndex(index))
                                                .animation(Animation.spring().delay(delayForIndex(index)), value: animate[index])
                                                .getSizeOfView { size in
                                                                    print("size of the Horizontal Card is: \(size)")
                                                    sizeOfCard = size
                                                                }
                                                .onTapGesture {
                                    
                                                    if(currentIndex == index){
                                                        withAnimation {
                                                            isTapped = true
                                                            currentItemX = authTypeVm.auths[currentIndex]
                                                        }
                                                    }
                                            }
                                     
                                    }
                                 
                                    .zIndex(1)
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
                            .frame(height: sizeOfCard.height)
                            .padding(.horizontal, 100)
                            .onPreferenceChange(ViewOffsetKey.self) { midXValues in
                                if let nearestIndex = nearestItemIndex(for: midXValues, in: size.width) {
                                    currentIndex = nearestIndex
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .defaultScrollAnchor(.center)
                    
               
                
                    Gap(h: 30)
                    SubTextView(backArrowOffset: backArrowOffset, forwardArrowOffset: forwardArrowOffset, scaleOpacity: scaleOpacity, scaleText: scaleText, textOffset: textOffset, textOpacity: textOpacity, opacity: opacity
                    )
                    Gap(h: 30)
                    Spacer()
                    Image("dot")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                    Gap(h: 30)
                }
                .onAppear{
                    withAnimation(.spring.delay(0.2)) {
                        appNameScale = 1
                        appNameOpacity = 1
                    }
                    withAnimation(.spring.delay(0.9)) {
                        opacity = 1
                        backArrowOffset = 15
                        forwardArrowOffset = -20
                    }
                    withAnimation(.spring.delay(1.1)) {
                        scaleText = 1
                        scaleOpacity = 1
                    }
                    withAnimation(.smooth(duration: 1).delay(1.5)) {
                        textOffset = 2
                        textOpacity = 1
                    }
                    withAnimation {
                        for i in animate.indices {
                            animate[i] = true
                        }
                        
                    }
                }
            }
        
            if isTapped {
                GeometryReader { v in
                    SampleViewX(namespace: nameSpacexx,
                                currentItem: currentItemX)
                    .onAppear{
                        //location.requestAllowOnceLocationPermission()
                    }
                }
            }
        }
        .frame(maxWidth:  UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
        .background(.onBoardingBG)
        .onAppear {
            if let screen = UIScreen.current {
                self.screenSize = screen.bounds.size
            }
        }
        //.ignoresSafeArea(.all)
        
        
    }
    
    
    private func nearestItemIndex(for midXValues: [CGFloat], in totalWidth: CGFloat) -> Int? {
           let centerX = totalWidth / 2
           let distances = midXValues.enumerated().map { (index, midX) in
               (index, abs(midX - centerX))
           }
           return distances.min(by: { $0.1 < $1.1 })?.0
       }
    
    private func xOffsetForIndex(_ index: Int) -> CGFloat {
           switch index {
           case 0:
               return animate[index] ? 0 : -UIScreen.main.bounds.width
           case 2:
               return animate[index] ? 0 : UIScreen.main.bounds.width
           default:
               return 0
           }
       }
       
       private func scaleForIndex(_ index: Int) -> CGFloat {
           return index == 1 ? (animate[index] ? 1 : 0.5) : 1
       }
    
    private func delayForIndex(_ index: Int) -> Double {
           switch index {
           case 0:
               return 0.6
           case 1:
               return 0.4
           case 2:
               return 0.6
           default:
               return 0
           }
       }
    
   
}

#Preview {
    AuthView()
        .environmentObject(PersonalInfoVM())
        .environmentObject(Router(root: Routes.AuthView))
}




struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []

    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

extension View {
    func getSizeOfView(_ getSize: @escaping ((CGSize) -> Void)) -> some View {
        return self
            .background {
                GeometryReader { geometry in
                    Color.clear.preference(key: SizePreferenceKey.self,
                                           value: geometry.size)
                    .onPreferenceChange(SizePreferenceKey.self) { value in
                        getSize(value)
                    }
                }
            }
    }
}






