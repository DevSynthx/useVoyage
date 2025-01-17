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
    @State private var offsetValues = [CGFloat](repeating: UIScreen.main.bounds.height / 2, count: 3)
    @State private var roadTicketOffset = [CGFloat](repeating: UIScreen.main.bounds.height / 2, count: 3)
    @State private var groupTicketOffset = [CGFloat](repeating: UIScreen.main.bounds.height / 2, count: 3)
    @State private var baecationTicketOffset = [CGFloat](repeating: UIScreen.main.bounds.height / 2, count: 2)
    @State private var girlsTicketOffset = [CGFloat](repeating: UIScreen.main.bounds.height / 2, count: 3)
    @State private var guysTicketOffset = [CGFloat](repeating: UIScreen.main.bounds.height / 2, count: 3)
    @State private var soloOffset: CGFloat = UIScreen.main.bounds.height / 2
    var body: some View {
        
        GeometryReader { geo in
            let size = geo.size
            ZStack (alignment: .bottom){
                VStack(alignment: .leading, spacing: 0){
                      
                        Gap(h:size.height / 30 )
                        Text("What trip is\nup next?")
                            .font(.customx(.bold, size: 30))
                            .foregroundStyle(.black)
                            .padding(.leading, 20)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        
                        Gap(h: 15)
                        Text("Select what type of trip you want to go for")
                            .font(.customx(.light, size: 14))
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
                                        
                                        view
                                            .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                           // .offset(x: phase.value * 100)
                                    }
                                    .padding(.horizontal, 20)
                                    .onTapGesture {
                                        withAnimation {
                                    guard currentIndex == v.offset else { return }
                                            vm.selectTrip(city: v.element)
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
                   // .scrollPosition(id: $tripType)
                    Gap(h: 20)
                    Text(vm.tripType[currentIndex].name)
                        .font(.customx(.semiBold, size: 16))
                        .foregroundStyle(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)

                    Gap(h: 30)
                    SwipeView()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)

                    }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                  
                switch vm.tripType[currentIndex].name {
                    case "Solo Adventure":
                        ZStack{
                            Image("planeTicket")
                                .resizable()
                                .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                    size * 0.6
                                }
                                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                .rotationEffect(.degrees(10), anchor: .center)
                                .offset(x: 10, y: soloOffset)
                                .transition(.slide)
                                .onAppear {
                                     withAnimation(.spring(duration: 0.5)) {
                                         soloOffset =  size.height / 5.7
                                     }
                                 }
                                .onDisappear{
                                    soloOffset = UIScreen.main.bounds.height / 2
                                }
                        }
                    case "Family Vacation":
                        ZStack{
                            ForEach(0..<3) { v in
                                Image("planeTicket")
                                    .resizable()
                                    .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                        size * 0.6
                                    }
                                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                    .rotationEffect(.degrees(v == 0 ? -15 : (v == 1 ? 2 : 15)), anchor: .center)
                                    .offset(x: v == 0 ? -30 : (v == 1 ? 0 : 50), y:  offsetValues[v])
                                    .transition(.slide)
                                    .onAppear {
                                         withAnimation(.spring(duration: 0.5).delay(Double(v) * 0.1)) {
                                             offsetValues[v] = size.height / 4.9
                                         }
                                     }
                                    .onDisappear{
                                        offsetValues[v] = UIScreen.main.bounds.height / 2
                                    }
                            }
                        }
                    case "Road Trip":
                        ZStack{
                            ForEach(0..<3) { v in
                                Image("carTicket")
                                    .resizable()
                                    .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                        size * 0.6
                                    }
                                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                    .rotationEffect(.degrees(v == 0 ? -15 : (v == 1 ? 2 : 15)), anchor: .center)
                                    .offset(x: v == 0 ? -30 : (v == 1 ? 0 : 50), y:  roadTicketOffset[v])
                                    .transition(.slide)
                                    .onAppear {
                                         withAnimation(.spring(duration: 0.5).delay(Double(v) * 0.1)) {
                                        // Adjust the value to control how far up the images slide
                                             roadTicketOffset[v] = size.height / 4.9
                                         }
                                     }
                                    .onDisappear{
                                        roadTicketOffset[v] = UIScreen.main.bounds.height / 2
                                    }
                            }
                        }
                    case "Baecation":
                        ZStack{
                            ForEach(0..<2) { v in
                                Image("planeTicket")
                                    .resizable()
                                    .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                        size * 0.6
                                    }
                                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                    .rotationEffect(.degrees(v == 0 ? 15 : (v == 1 ? -15 : 15)), anchor: .center)
                                    .offset(x: v == 70 ? 40 : (v == 1 ? -60 : 50), y:  baecationTicketOffset[v])
                                    .transition(.slide)
                                    .onAppear {
                                         withAnimation(.spring(duration: 0.5).delay(Double(v) * 0.1)) {
                                        // Adjust the value to control how far up the images slide
                                             baecationTicketOffset[v] = size.height / 4.9
                                         }
                                     }
                                    .onDisappear{
                                        baecationTicketOffset[v] = UIScreen.main.bounds.height / 2
                                    }
                            }
                        }
                    case "Group travel":
                        ZStack{
                            ForEach(0..<3) { v in
                                Image("planeTicket")
                                    .resizable()
                                    .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                        size * 0.6
                                    }
                                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                    .rotationEffect(.degrees(v == 0 ? -15 : (v == 1 ? 2 : 15)), anchor: .center)
                                    .offset(x: v == 0 ? -30 : (v == 1 ? 0 : 50), y:  groupTicketOffset[v])
                                    .transition(.slide)
                                    .onAppear {
                                         withAnimation(.spring(duration: 0.5).delay(Double(v) * 0.1)) {
                                        // Adjust the value to control how far up the images slide
                                             groupTicketOffset[v] = size.height / 4.9
                                         }
                                     }
                                    .onDisappear{
                                        groupTicketOffset[v] = UIScreen.main.bounds.height / 2
                                    }
                            }
                        }
                    case "Girls' trip":
                        ZStack{
                            ForEach(0..<3) { v in
                                Image("planeTicket")
                                    .resizable()
                                    .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                        size * 0.6
                                    }
                                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                    .rotationEffect(.degrees(v == 0 ? -15 : (v == 1 ? 2 : 15)), anchor: .center)
                                    .offset(x: v == 0 ? -30 : (v == 1 ? 0 : 50), y:  girlsTicketOffset[v])
                                    .transition(.slide)
                                    .onAppear {
                                         withAnimation(.spring(duration: 0.5).delay(Double(v) * 0.1)) {
                                        // Adjust the value to control how far up the images slide
                                             girlsTicketOffset[v] = size.height / 4.9
                                         }
                                     }
                                    .onDisappear{
                                        girlsTicketOffset[v] = UIScreen.main.bounds.height / 2
                                    }
                            }
                        }
                    case "Guys' trip":
                        ZStack{
                            ForEach(0..<3) { v in
                                Image("planeTicket")
                                    .resizable()
                                    .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                        size * 0.6
                                    }
                                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                    .rotationEffect(.degrees(v == 0 ? -15 : (v == 1 ? 2 : 15)), anchor: .center)
                                    .offset(x: v == 0 ? -30 : (v == 1 ? 0 : 50), y:  guysTicketOffset[v])
                                    .transition(.slide)
                                    .onAppear {
                                         withAnimation(.spring(duration: 0.5).delay(Double(v) * 0.1)) {
                                             guysTicketOffset[v] = size.height / 4.9
                                         }
                                     }
                                    .onDisappear{
                                        guysTicketOffset[v] = UIScreen.main.bounds.height / 2
                                    }
                            }
                        }
                    default:
                        Text("")
                }
            
          
                
                HStack{
                    Text("\(vm.tripType[currentIndex].name)  selected")
                        .font(.customx(.semiBold, size: 18))
                        .foregroundStyle(.black)
                    Spacer()
                    NextButton {
                        vm.selectTrip(city:vm.tripType[currentIndex])
                        router.push(to: .BudgetType)
                    }
                   
                }
                .padding(.bottom, 30)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .background {
                    Rectangle()
                          .foregroundStyle(.white)
                          .shadow(color: .gray.opacity(0.1), radius: 3.5, y: -5)
                          
                }
                .offset(y: 0)
                .animation(.smooth, value: countOffset)
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



