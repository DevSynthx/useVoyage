//
//  ChooseSeasonView.swift
//  Voyage
//
//  Created by Inyene Etoedia on 04/07/2024.
//

import SwiftUI

struct ChooseSeasonView: View {
    @EnvironmentObject var vm: PersonalInfoVM
    @Environment(\.router) var router
    @State private var timer: Timer?
    @State var offset: CGFloat = 0
    @State var lastoffset: CGFloat = 0
    @State var isOpen: Bool = false
    @State var isDragged: Bool = false
    @State var showScreen: Bool = false
    @State var firstAppear: Bool = false
    @State private var offsetx: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    let size = UIScreen.main.bounds.size
    @GestureState var gestureoffset: CGFloat = 0
    @State private var centeredIndex = 3
    @State private var sizeOfCard: CGSize = .zero
    let months : [String] = [
    "DEC. JAN. FEB.",
    "JUN. JUL. AUGT.",
    " MAR. APR. MAY.",
    "SEPT. OCT. NOV.",
    ]
    let seasons : [String] = [
    "autumn",
    "spring",
    "summer",
    "winter",
    ]
  
    var colors: [Color] = [.blue, .green, .red, .orange]
    var body: some View {
        
        VStack{
            VStack{
                ZStack(alignment: .top){
                    Image("seasonBG2")
                        .resizable()
                        .scaledToFill()
                       // .frame(width: size.width, height: size.height)
                        .offset(y: -size.height / 7.0)
                        .fixedSize()
                        .containerRelativeFrame(.vertical, { size, _ in
                            size * 1.01
                        })
                        .getSizeOfView { size in
                            sizeOfCard = size
                        }
                      

                    Image("seasonBG")
                        .resizable()
                        .scaledToFill()
                        .padding(40)
                        .containerRelativeFrame(.vertical, { size, _ in
                            size * 1
                        })
                        .offset(y: -size.height / 7.3)

                    Image("imageMask")
                        .resizable()
                        .scaledToFill()
                        .padding(60)
                        .containerRelativeFrame(.vertical, { size, _ in
                            size * 1
                        })
                        .offset(y: -size.height / 6.5)

                    Image(seasons[centeredIndex])
                        .resizable()
                        .scaledToFill()
                        .padding(85)
                        //.frame(width: size.width, height: size.height)
                        .containerRelativeFrame(.vertical, { size, _ in
                            size * 1
                        })
                        .offset(y: -size.height / 7.0)
                    
                    
                    Image("dragSheet")
                        .resizable()
                        //.padding(.horizontal, 15)
                        .foregroundStyle(.white)
                        .containerRelativeFrame(.vertical, { size, _ in
                            size * 0.9
                        })
                        .overlay(alignment: .top){
                            VStack(alignment: .center){
                            
                                Gap(h: 100)
                                Text("Picture your\nideal vacation")
                                    .font(.system(size: 35, weight: .semibold))
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 25)
                                    .frame(width: size.width, alignment: .leading)
                                 
                                Gap(h: 20)
                                Text("Now let's pick the perfect season for it!")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 25)
                                    .frame(width: size.width, alignment: .leading)
                                
                                Spacer()
                                if isDragged {
                                    VStack{
                                        Image("drag_icon")
                                            .rotationEffect(.degrees(180))
                                            .offset(y:  offsetx)
                                        Text("DRAG DOWN TO CHOOSE")
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundStyle(.black)
                                    }
                                    .onAppear{
                                        startAnimating()
                                       //isAnimating = true
                                    }
                                } else {
                                    VStack{
                                        Image("drag_icon")
                                            .offset(y:  offsetx)
//                                            .animation(.spring(duration: 1).delay(0.3).repeatForever(autoreverses: true), value: isAnimating)
                                        Text("DRAG UP TO START")
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundStyle(.black)
                                    }
                                    .onAppear{
                                        startAnimating()
                                       //isAnimating = true
                                    }
                                }
                                
                                Gap(h: 20)
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 50, height: 10)
                                    .foregroundStyle(.black)
                               //Spacer()
                               Gap(h: 50)
                                   
                            }
                            .frame(maxHeight: size.height, alignment: .topLeading)
                            .ignoresSafeArea(.all, edges: .bottom)
                        }
                      
                       
                    //                    .offset(y: -height / 5)
                        .offset(y: -size.height + size.height - 10 )
                        .offset(y: calculateOffset(offset: offset, height: size.height))
                        .offset(y: offset)
                        .mask {
                            Image("mask_bg")
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width -  200,  height: size.height )
                                .offset(y: -size.height / 8.5)

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
                                        }
                                        withAnimation {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                self.isDragged = true
                                            }
                                        }
                                        
                                    } else {
                                        withAnimation {
                                            self.isOpen = false
                                        }
                                        offset = 0
                                        stopTimer()
                                        router?.push(to: .GetStartedView)
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
                    //.opacity(isOpen ? 0 : 1)
                    
                }
            }
            .frame(maxHeight: sizeOfCard.height )
            if isOpen {
                Gap(h: 35)
                SwipeView(color: .white)
                Gap(h: 35)
                Text(seasons[centeredIndex].capitalized)
                    .font(.custom(.bold, size: 35))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .animation(.interactiveSpring, value: seasons[centeredIndex])
                Gap(h: 15)
                
                HStack(alignment: .center, spacing: 30) {
                    ForEach(months.indices, id:\.self) { i in
                        Text(months[i])
                            .font(.custom(.regular, size: 15))
                            .foregroundStyle(.white)
                            .frame(width: 135)
                            .foregroundStyle((centeredIndex - 3) == (-i) ? .white : .greyX.opacity(0.4))
                        //.frame(width: 120, height: 100, alignment: .center)
                        
                    }
                }.modifier(ScrollingHStackModifier(items: colors.count, itemWidth: 138, itemSpacing: 30, centeredIndex: $centeredIndex)) // Adjusted itemWidth to 50 and itemSpacing to 10
                
                Gap(h: size.height / 4.0)
            }

            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
        .background(.seasonViewBg)
        .navigationBarBackButtonHidden(true)
               
      
    }
    private func startAnimating() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
               withAnimation(.spring(duration: 1)) {
                   offsetx += -20 * direction
               }
               direction *= -1
               
           }
       }
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
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
            // Only update offset if gestureoffset is negative (upward drag)
            if gestureoffset < 0 {
             
            }
            self.offset = gestureoffset + lastoffset
        }
    }
}

#Preview {
    ChooseSeasonView()
        .environmentObject(PersonalInfoVM())
        .environmentObject(Router(root: Routes.AuthView))
}









struct ScrollingHStackModifier: ViewModifier {
    
    @State private var scrollOffset: CGFloat
    @State private var dragOffset: CGFloat
    @Binding var centeredIndex: Int
    
    var items: Int
    var itemWidth: CGFloat
    var itemSpacing: CGFloat
    
    init(items: Int, itemWidth: CGFloat, itemSpacing: CGFloat, centeredIndex: Binding<Int>) {
        self.items = items
        self.itemWidth = itemWidth
        self.itemSpacing = itemSpacing
        self._centeredIndex = centeredIndex
        
        // Calculate Total Content Width
        let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
        let screenWidth = UIScreen.main.bounds.width
        
        // Set Initial Offset to first Item
        let initialOffset = (contentWidth/2.0) - (screenWidth/2.0) + ((screenWidth - itemWidth) / 2.0)
        
        self._scrollOffset = State(initialValue: initialOffset)
        self._dragOffset = State(initialValue: 0)
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: scrollOffset + dragOffset, y: 0)
            .gesture(DragGesture()
                .onChanged { event in
                    dragOffset = event.translation.width
                }
                .onEnded { event in
                    // Scroll to where user dragged
                    scrollOffset += event.translation.width
                    dragOffset = 0
                    
                    // Now calculate which item to snap to
                    let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
                    let screenWidth = UIScreen.main.bounds.width
                    
                    // Center position of current offset
                    let center = scrollOffset + (screenWidth / 2.0) + (contentWidth / 2.0)
                    
                    // Calculate which item we are closest to using the defined size
                    var index = (center - (screenWidth / 2.0)) / (itemWidth + itemSpacing)
                    
                    // Should we stay at current index or are we closer to the next item...
                    if index.remainder(dividingBy: 1) > 0.5 {
                        index += 1
                    } else {
                        index = CGFloat(Int(index))
                    }
                    
                    // Protect from scrolling out of bounds
                    index = min(index, CGFloat(items) - 1)
                    index = max(index, 0)
                    
                    // Set the centered index
                    centeredIndex = Int(index)
                    
                    // Set final offset (snapping to item)
                    let newOffset = index * itemWidth + (index - 1) * itemSpacing - (contentWidth / 2.0) + (screenWidth / 2.0) - ((screenWidth - itemWidth) / 2.0) + itemSpacing
                    
                    // Animate snapping
                    withAnimation {
                        scrollOffset = newOffset
                     
                    }
                }
            )
    }
}















extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

