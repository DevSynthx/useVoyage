//
//  TripTypeView.swift
//  project-z
//
//  Created by Inyene Etoedia on 24/06/2024.
//

import SwiftUI

struct TripTypeView: View {
    @FocusState var isFocused: Bool
    @EnvironmentObject var vm: PersonalInfoVM
    @EnvironmentObject var router: Router<Routes>
    @State private var countOffset: CGFloat = 70
    @State private var showCount: Bool = false
    @State var text: String = ""
    @State var showSearch: Bool = false
    @Namespace var nameSpace
    @State private var contentHeight: CGSize = .zero
    @State var tripType: TripTypeModel?
    @State private var currentIndex: Int = 0
    var body: some View {
        
        GeometryReader { geo in
            let size = geo.size
            ZStack (alignment: .bottom){
                VStack(alignment: .leading, spacing: 0){
                      
                        Gap(h:size.height / 30 )
                        Text("What trip is\nup next?")
                            .font(.custom(.bold, size: 30))
                            .foregroundStyle(.black)
                            .padding(.leading, 20)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        
                        Gap(h: 15)
                        Text("Select what type of trip you want to go for")
                            .font(.custom(.light, size: 14))
                            .foregroundStyle(.gray)
                            .padding(.leading, 20)
                    
                    Gap(h: 35)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(vm.tripType.enumerated().map{$0}, id: \.element.name) { v in
                                
                              
                                Image(v.element.image)
                                    .resizable()
                                    .scaledToFit()
                                    .containerRelativeFrame([.horizontal], { size, axis in
                                        size * 0.60
                                    })
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(currentIndex == v.offset ? .blue.opacity(0.4) : .clear, lineWidth: 3)
                                    }
                                    .background(GeometryReader { itemGeo in
                                        Color.clear
                                            .preference(key: ViewOffsetKey.self, value: [itemGeo.frame(in: .global).midX])
                                    })
                                    .scrollTransition(.interactive, axis: .horizontal){
                                        view, phase in
                                        
                                        view.scaleEffect(phase.isIdentity ? 1 : 0.85)
                                        
                                    }
                                    .padding(.horizontal, 20)
                                    .onTapGesture {
                                        withAnimation {
                                            guard currentIndex == v.offset else {
                                                return
                                            }
                                            vm.selectTrip(city: v.element)
                                            if(!vm.tripType.isEmpty){
                                                countOffset = 5
                                                showCount = true
                                            } else{
                                                countOffset = 40
                                                showCount = false
                                            }
                                          
                                           
                                        }
                                       
                                    }

                            }
                        }
                        .padding(.horizontal, 50)
                        .scrollTargetLayout()
                        .onPreferenceChange(ViewOffsetKey.self) { midXValues in
                            if let nearestIndex = nearestItemIndex(for: midXValues, in: geo.size.width) {
                                currentIndex = nearestIndex
                            }
                        }
                    }
                    .safeAreaPadding(.horizontal, 20)
                    .scrollClipDisabled()
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $tripType)
                    Gap(h: 20)
                    Text(vm.tripType[currentIndex].name)
                        .font(.custom(.semiBold, size: 14))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)

                    Gap(h: 30)
                    HStack(alignment: .center, spacing: 40) {
                        Image("arrow_right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .rotationEffect(.degrees(180))
                        
                        Text("SWIPE")
                            .font(.custom(.regular, size: 14))
                            .foregroundStyle(.black)
                            .kerning(5)
                        Image("arrow_right")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)

                    }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            
                if(!vm.singleTrip.isEmpty){
                    ZStack {
                        if(vm.singleTrip == "Road Trip"){
                            Image("carTicket")
                                .resizable()
                                .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                    size * 0.72
                                }
                                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                .rotationEffect(.degrees(10))
                                .offset(y: size.height / 3.5)
                        }else{
                            Image("planeTicket")
                                .resizable()
                                .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                    size * 0.7
                                }
                                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                .rotationEffect(.degrees(10))
                                .offset(y: size.height / 3.5)
                        }
                       
                    }
                    .shadow(color: .gray.opacity(0.3),  radius: 20)
                }
                
                HStack{
                    Text("\(vm.singleTrip)  selected")
                        .font(.custom(.semiBold, size: 18))
                        .foregroundStyle(.black)
                    Spacer()
                    NextButton {
                        router.push(to: .BudgetType)
                    }
                   
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .background {
                    Rectangle()
                          .foregroundStyle(.white)
                          .shadow(color: .gray.opacity(0.1), radius: 3.5, y: -5)
                }
                .offset(y: countOffset)
                .animation(.smooth, value: countOffset)
                .opacity(showCount ? 1 : 0)
                .transition(.move(edge: .bottom))

            }
            
            
            .frame(maxWidth: UIScreen.main.bounds.width,   maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(.white)
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarBackButtonHidden(true)
        }
        .backgroundStyle(.white)
    }
    
    private func nearestItemIndex(for midXValues: [CGFloat], in totalWidth: CGFloat) -> Int? {
           let centerX = totalWidth / 2
           let distances = midXValues.enumerated().map { (index, midX) in
               (index, abs(midX - centerX))
           }
           return distances.min(by: { $0.1 < $1.1 })?.0
       }
}

#Preview {
    TripTypeView()
        .environmentObject(PersonalInfoVM())
        .environmentObject(Router(root: Routes.BudgetType))
}



