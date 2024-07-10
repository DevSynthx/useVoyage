//
//  DragView.swift
//  Voyage
//
//  Created by Inyene Etoedia on 09/07/2024.
//

import SwiftUI

struct DragView: View {
    let size = UIScreen.main.bounds.size
    @GestureState var gestureoffset: CGFloat = 0
    @State private var centeredIndex = 3
    @State private var sizeOfCard: CGSize = .zero
    @Binding var offset: CGFloat
    //= -300
    @State var lastoffset: CGFloat = 0
    @Binding var value: Bool
    @State var isOpen: Bool = false
    @State var isDragged: Bool = false
    var body: some View {
        ZStack{
            Image("windowBorder")
            Image("onBoardBG_A")
            Image("onBoardBG_B")
            Image("onBoardBG_B")
            Image("onBoardBG_C")
            Image("onBoardImg")
                .resizable()
                //.scaledToFill()
                .padding(.horizontal, 70)
                .padding(.vertical, 60)
                .containerRelativeFrame(.vertical, { size, _ in
                    size * 0.6
                })
                .containerRelativeFrame(.horizontal, { size, _ in
                    size * 1
                })
                .mask {
                    Image("onBoardBG_C")
                }
                //.resizable()
               // .scaledToFill()
              
            Image("onBoardBG_dragg")
                .overlay(alignment: .bottom){
                    VStack(alignment: .center){
                        Spacer()
                        
                        Image("drag_icon")
                        Text("DRAG UP TO EXPLORE")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Gap(h: 10)
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 50, height: 10)
                            .foregroundStyle(.black)
                       //Spacer()
                       Gap(h: 40)
                           
                    }
                    .frame(maxHeight: size.height, alignment: .topLeading)
                    .ignoresSafeArea(.all, edges: .bottom)
                }
                .offset(y: -size.height + size.height - 10 )
                .offset(y: calculateOffset(offset: offset, height: size.height))
                .offset(y: offset)
                .mask {
                    Image("onBoardBG_C")
                }
                .gesture(
                    DragGesture().updating($gestureoffset, body: { value, out, _ in
                        out = value.translation.height
                        onChange()
                       
                    }).onEnded({ v in
                        
                        let maxHeight = size.height - 200
                       
                        withAnimation {
                            // print("offset: \(offset)")
                            if offset > 0 && offset > maxHeight / 2 {
                                
                                offset = (maxHeight / 3)
                                // print("printing here \(offset)")
                            }
                            else if -offset > maxHeight / 4 {
                                offset = -(maxHeight / 1.9)
                                withAnimation {
                                    self.isOpen = true
                                    self.value = true
                                }
                                withAnimation {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        self.isDragged = true
                                    }
                                }
                                
                            } else {
                                withAnimation {
                                    self.isOpen = false
                                    self.value = false
                                }
                                offset = 0
                               // router.push(to: .GetStartedView)
                                withAnimation {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        self.isDragged = false
                                    }
                                }

                            }
                            
                        }
                        
                        //-----> Store offset here
                        lastoffset = offset
                    })
                    
                    
                )
            
        }
       // .background(.onBoardingBG)
    }
    
    func calculateOffset(offset: CGFloat, height: CGFloat) -> CGFloat {
        if offset < 10{
            print("offset: \(offset)")
            return -0
        }
           if offset >= 100 {
               //303
    
//               var res =  -offset <= (height - 150) ? -offset * 2 : -(height / 1.8)
//               print("result: \(-offset * 2)")
//               print("calculation: \(-(height / 1.8))")
               
              // print("printing here \(offset)")
               return  -offset * 2.3
           } else {
               return -0
           }
       }
    func onChange(){
        DispatchQueue.main.async {
            self.offset = gestureoffset + lastoffset
        
        }
    }
}

#Preview {
    DragView(offset: .constant(-350), value: .constant(false))
}
