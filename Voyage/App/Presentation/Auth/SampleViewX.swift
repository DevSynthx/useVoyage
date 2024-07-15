//
//  SampleViewX.swift
//  project-z
//
//  Created by Inyene Etoedia on 14/06/2024.
//

import SwiftUI

struct SampleViewX: View {
    @EnvironmentObject var vm: PersonalInfoVM
    @EnvironmentObject var location: LocationManagerVM
    var namespace: Namespace.ID
    var currentItem: AuthType
    @State var offset: CGFloat = 0
    @State var handoffset: CGFloat = 20
    @State var lastoffset: CGFloat = 0
    @State var isOpen: Bool = false
    @State var showScreen: Bool = false
    @State var firstAppear: Bool = false    
    @GestureState var gestureoffset: CGFloat = 0
    var body: some View {
        GeometryReader { geo in
            let height = geo.frame(in: .global).height
            let width = geo.frame(in: .global).width
            ZStack{
               
                Image("backseat")
                      .resizable()
                      .mask(alignment: .center){
                          Image("mask_bg")
                              .resizable()
                              .scaledToFill()
                              .scaleEffect(isOpen ? 2 : 1)
                      }
                      .matchedGeometryEffect(id: currentItem.logo, in: namespace)
                
                VStack(spacing: 0){
                    Spacer()
                    MiniScreen(height: height , width: width)
                    .opacity(showScreen ? 1 : 0)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                            self.showScreen = true
                        }
                    }
                    .zIndex(1)
        
                    ZStack(alignment: .center){
                        Image("hand")
                        
                        Text(vm.username.truncate(10))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.passportText)
                            .rotationEffect(Angle(degrees: -20))
                            .offset(y: -140)
                        
                    }
                    .scaleEffect(1)
                    .offset(y: handoffset)
                    .opacity(isOpen ? 1 : 0)
                    .transition(.slide)

                }
                
                ZStack{
                    Image("large_sheet")
                        .resizable()
                        .overlay{
                            VStack(alignment: .leading){
                                Gap(h: 70)
                                Text("Enjoy the full\nexperience")
                                    .font(.custom(.bold, size: 40))
                                    .foregroundStyle(.white)
                                Gap(h: 30)
                                Text("Turn on your app location to\nhelp us give you a more tailored\nexperience.")
                                    .font(.custom(.regular, size: 15))
                                    .lineSpacing(5)
                                    .foregroundStyle(.white)
                                    
                                   
                            }
                            .frame(maxHeight: height / 1.5, alignment: .top)
                            //.ignoresSafeArea(.all, edges: .bottom)
                        }
                        .offset(y: -height + height - 50 )
    //                    .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                        .offset(y: offset >= 100 ? -offset <= (height - 150) ? -offset : (height - 50) : -50)
                        .offset(y: offset)
                        .mask {
                            Image("mask_bg")
                               .resizable()
                               .scaledToFill()
                               .frame(width: width -  200)
                        }
                        .opacity(isOpen ? 0 : 1)
                     
             
                Image("borderx")
                    .resizable()
                    .gesture(
                        DragGesture().updating($gestureoffset, body: { value, out, _ in
                            if value.translation.height < 0 {
                                out = value.translation.height
                            }
                           
                            onChange()
                           
                        }).onEnded({ v in
                            
                            let maxHeight = height - 200
                            withAnimation {
                                if offset > 0 && offset > maxHeight / 2 {
                                
                                 offset = (maxHeight / 3)
                                    print("printing here \(offset)")
                                }
                                else if -offset > maxHeight / 2 {
                                    offset = -maxHeight
                                    withAnimation {
                                        isOpen = true
                                        self.handoffset = 0
                                    }
                                 
                                } else {
                                 
                                    offset = 0
                                }
                              
                            }
                            
                            //-----> Store offset here
                            lastoffset = offset
                        })
                    
                    
                    )
                    .opacity(isOpen ? 0 : 1)
                }
                .matchedGeometryEffect(id: currentItem.title, in: namespace)
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.12)
                .frame(width: geo.size.width, height: height, alignment: .top)
                .frame(height: geo.size.height, alignment: .bottom)
                .ignoresSafeArea(.all, edges: .bottom)
               
            }
            .frame(height: UIScreen.main.bounds.height, alignment: .bottom)
            .ignoresSafeArea(.all)
            .onAppear{
               // location.requestAllowOnceLocationPermission()
            }
            
        }
        .ignoresSafeArea(.keyboard)
       
      
    }
    
    func onChange(){
        
        DispatchQueue.main.async {
            if gestureoffset < 0 {
                self.offset = gestureoffset + lastoffset
            }
           // self.offset = gestureoffset + lastoffset
        
        }
    }
}

#Preview {
    SampleViewX(namespace:  Namespace().wrappedValue, currentItem: .model())
        .environmentObject(PersonalInfoVM())
        .environmentObject(LocationManagerVM())

}

extension HorizontalAlignment {
    private enum CustomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            // Return the default value (typically 0)
            return context[HorizontalAlignment.center]
        }
    }
    
    static let customAlignment = HorizontalAlignment(CustomAlignment.self)
}
