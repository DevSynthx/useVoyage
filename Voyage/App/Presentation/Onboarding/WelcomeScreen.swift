////
////  WelcomeScreen.swift
////  project-z
////
////  Created by Inyene Etoedia on 20/03/2024.
////
//
//import SwiftUI
//
//struct WelcomeScreen: View {
//    @State private var bottomSheetShown = false
//    @GestureState private var translation: CGFloat = 0
//    
//    @State private var offset : CGFloat = -40
//    var body: some View {
//        GeometryReader { geometry in
//        
//            BottomSheetView(
//                isOpen: self.$bottomSheetShown,
//                maxHeight: geometry.size.height
//                
//            ) {
//                VStack{
//                   Text("hello")
//                }
//            }
//        }.edgesIgnoringSafeArea(.all)
////        ZStack{
////            Image("large_border")
////                .zIndex(1)
////                .gesture(
////                    DragGesture().updating(self.$translation) { value, state, _ in
////                        print(value.location)
////                        withAnimation(.interactiveSpring) {
////                            state = value.translation.height
////                        }
////                   
////                    }.onEnded { value in
////                        withAnimation(.interactiveSpring) {
//////                            let snapDistance = self.maxHeight * Constants.snapRatio
//////                            print(snapDistance)
//////                            guard abs(value.translation.height) > snapDistance else {
//////                                return
//////                            }
////                        }
////                        withAnimation {
//////                            self.isOpen = value.translation.height < 0
////                        }
////                   
////                    }
////                )
////            Image("large_sheet")
////                .offset(y: self.offset)
////                .mask {
////                    Image("mask_bg")
////                }
////           
////          
////            
////            
////        }
////        .ignoresSafeArea(.all, edges: .top)
//    
//    }
//}
//
//#Preview {
//    WelcomeScreen()
//}
//
//
//
//
//
//
//
////fileprivate enum Constants {
////    static let radius: CGFloat = 16
////    static let indicatorHeight: CGFloat = 6
////    static let indicatorWidth: CGFloat = 60
////    static let snapRatio: CGFloat = 0.25
////    static let minHeightRatio: CGFloat = 0.3
////}
////
////struct BottomSheetView<Content: View>: View {
////    @Binding var isOpen: Bool
////
////    let maxHeight: CGFloat
////    let minHeight: CGFloat
////    let content: Content
////    let cardPopAnimationResponse: Double = 0.5
////    @GestureState private var translation: CGFloat = 0
////
////    private var offset: CGFloat {
////        isOpen ? -75 : UIScreen.main.bounds.height / -1.8
////    }
////
////    private var indicator: some View {
////        RoundedRectangle(cornerRadius: Constants.radius)
////            .fill(Color.secondary)
////            .frame(
////                width: Constants.indicatorWidth,
////                height: Constants.indicatorHeight
////        ).onTapGesture {
////            withAnimation(.interactiveSpring(response: self.cardPopAnimationResponse)) {
////                self.isOpen.toggle()
////            }
////        }
////    }
////
////    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
////        self.minHeight = maxHeight * Constants.minHeightRatio
////        self.maxHeight = maxHeight
////        self.content = content()
////        self._isOpen = isOpen
////    }
////
////    var body: some View {
////        GeometryReader { geometry in
////            ZStack{
////                Image("large_sheet")
////                    .offset(y: max(self.offset + self.translation, -maxHeight + minHeight))
////                    .animation(.interactiveSpring())
////                    //.animation(.interactiveSpring, value: isOpen)
////                   
////                    .mask {
////                        Image("mask_bg")
////                    }
////                Image("large_border")
////                    .gesture(
////                        DragGesture().updating(self.$translation) { value, state, _ in
////                            
////                            withAnimation(.interactiveSpring) {
////                                state = value.translation.height
////                            }
////                       
////                        }.onEnded { value in
////                            withAnimation(.interactiveSpring) {
////                                let snapDistance = self.maxHeight * Constants.snapRatio
////                               
////                                guard abs(value.translation.height) > snapDistance else {
////                                    return
////                                }
////                            }
////                            withAnimation {
////                                self.isOpen = value.translation.height > 0
////                            }
////                       
////                        }
////                    )
////                
////                
////            }
////            .frame(width: geometry.size.width, height: self.maxHeight , alignment: .top)
////            .frame(height: geometry.size.height, alignment: .bottom)
////          
////
////        }
////    }
////}
