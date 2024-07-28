//
//  MiniScreen.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/06/2024.
//


enum ContinueState {
    case start
    case enterName
    case getStarted
    case cards
}

import SwiftUI

struct MiniScreen: View {
    @EnvironmentObject var router: Router<Routes>
    @EnvironmentObject var vm: PersonalInfoVM
    var height : CGFloat
    var width : CGFloat
    @State var text: String = "David"
    @State var isContinue: Bool = false
    @State var isDone: Bool = false
    @State var formState: ContinueState = .start
    var body: some View {
        
        ZStack{
         
            Rectangle()
                .cornerRadius(20)
                .frame(width: width / 1.1, height: height / 3)
                .foregroundStyle(.black)
                .overlay{
                    Image("screen_buttons")
                         .resizable()
                         .scaledToFit()
                         .frame(maxHeight: .infinity, alignment: .bottom)
                         .padding(.horizontal, 22)
                         .padding(.bottom, 7)
                }
                
            Rectangle()
                .fill(LinearGradient(
                                   gradient: Gradient(colors: [Color(hex: "FF87C7"), Color(hex: "48ACF0")]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
                .cornerRadius(15)
                .frame(width: width / 1.3, height: height / 3.9)
                .overlay{
                    VStack {
                        switch formState {
                            case .start:
                                WelcomeView()
                            case .enterName:
                                EnterNameView(username: $vm.username)
                            case .getStarted:
                                DisplayNameView(name: $vm.username)
                            case .cards:
                                CardViewScreen()
                                
                        }
                        
                       Spacer()
                        if [.start, .enterName].contains(formState){
                            AppButton(action:{
                              
                                withAnimation {
                                    switch formState {
                                        case .start:
                                            self.formState = .enterName
                                            print(self.formState)
                                        case .enterName:
                                            guard !vm.username.isEmpty else {
                                                print("Error")
                                                return
                                            }
                                            self.formState = .getStarted
                                            print(self.formState)
                                        case .getStarted:
                                            self.formState = .cards
                                            print(self.formState)
                                        case .cards:
                                            self.formState = .cards
                                    }
                                  
                                }
                            })
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottomTrailing)
                            .padding(.trailing, 10)
                        }
                        else if(formState == .cards){
                            EmptyView()
                        }
                        else {
                            HStack(alignment: .center){
                                AppButton(action:{
                                    withAnimation {
                                        self.formState = .getStarted
                                    }
                                },
                                title: "Edit Name",
                                textColor: .white,
                                bgColor: .black
                                )
                                Spacer()
                                AppButton(action:{
                                    withAnimation {
                                        self.formState = .cards
                                    }
                                  //  router.push(to: .GetStartedView)
                                },
                                title: "Get Started"
                                )
 
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal, 20)
                        }
                        
                        Gap(h: 10)
                    }
                    .padding(.top, 15)
                  
                }
            
        }
      
    }
}

#Preview {
    GeometryReader { geo in
        MiniScreen(height: geo.size.height, width: geo.size.width)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
    .environmentObject(PersonalInfoVM())
    .environmentObject(Router(root: Routes.GetStartedView))
}






struct CardViewScreen: View {
    @EnvironmentObject var vm: PersonalInfoVM
    @Environment(\.router) var router
    var width = UIScreen.main.bounds.width
    @State var currentIndex : Int = 0
    @State private var progress: CGFloat = 20.0
    @State private var contentHeight: CGSize = .zero
    let text = "We have\nmapped out\nthe perfect\ngetaway for you"
    let textB = "Choose a\ncategory to\nget started"
    var body: some View {
        GeometryReader { geo in
           
                VStack {
                  
                    Image("plane_icon")
                        .resizable()
                        .scaledToFill()
                        .containerRelativeFrame(.horizontal, { size, _ in
                            size * 0.26
                        })
                        .frame(maxWidth: .infinity, alignment: . trailing)
                        
                    Gap(h: 10)
                    HStack(spacing: 0) {
                        ZStack {
                            ForEach(Array(vm.cards.enumerated()), id: \.element.id) { index, card in
                                VStack{
                                    Image("personalityIcon")
                                    Gap(h: 10)
                                    Text(card.name)
                                        .font(.customx(.medium, size: 12))
                                        .foregroundStyle(.black)
                                }
                                .frame(width: 100, height: 115)
                                .background{
                                    Rectangle()
                                        .fill(card.color)
                                        .frame(width: 100, height: 115)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .padding()
                                }
                                   .offset(x: offsetForx(index: index))
                                   .scaleEffect(scaleForx(index: index), anchor: .center)
                                   .zIndex(Double(vm.cards.count - index)) // Ensure correct layering
                                    .overlay(
                                        GeometryReader { geo in
                                            Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size)
                                        }
                                    )
                                    .background(GeometryReader { itemGeo in
                                        Color.clear
                                            .preference(key: ViewOffsetKey.self, value: [itemGeo.frame(in: .global).midX])
                                    })
                                    .contentShape(Rectangle())
                                    .onTapGesture(perform: {
                                        if vm.selectedTrip.ticketCount == 0 && vm.cards[currentIndex].name == "Personality" {
                                            router?.push(to: .PersonalityView)
                                        } else if (vm.selectedTrip.ticketCount != 0) {
                                            //router?.resetAndPush(to: .HomeScreen)
                                        }
                                    })
                                    .gesture(
                                        DragGesture()
                                            .onEnded { value in
                                                if value.translation.width < -50 || value.translation.width > 50 {
                                                   moveCards(index: index)
                                                   
                                                }

                                            }
                                    )

                            }
                            
                        }
                    
                        Gap(w: 20)
                        Image(systemName: "arrow.forward")
                            .foregroundStyle(.white)
                            .padding(8)
                            .background{
                                Circle()
                                    .stroke(.white, lineWidth: 2)
                            }
                            .onTapGesture {
                               moveCards(index: currentIndex)
                            }
                        Gap(w: 15)
                        Text(vm.selectedTrip.ticketCount != 0 ? textB : textB)
                            .font(.customx(.bold, size: 15))
                            .lineSpacing(3)
                            .foregroundStyle(.white)
                     
                    }
                    .frame(height: contentHeight.height / 1.2)
                    .padding(.trailing, 1)
                    .onPreferenceChange(HeightPreferenceKey.self, perform: { value in
                        self.contentHeight = value
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { midXValues in
                        if let nearestIndex = nearestItemIndex(for: midXValues, in: geo.size.width) {
                            currentIndex = nearestIndex
                        }
                    }
                    Gap(h: vm.selectedTrip.ticketCount != 0 ? 10 : 30)
                    HStack(alignment: .bottom){
                        ZStack{
                            Rectangle()
                                .frame(width: 100, height: 3, alignment: .leading)
                                .foregroundColor(.gray.opacity(0.3))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 21)
                            Rectangle()
                                .frame(width: progress, height: 3, alignment: .leading)
                                .foregroundColor(.white)
                                .animation(.easeInOut(duration: 0.5), value: progress)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 21)
                        }
                       
                        if(vm.selectedTrip.ticketCount != 0){
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                HStack{
                                  Text("Show me")
                                        .font(.customx(.semiBold, size: 13))
                                        .foregroundStyle(.black)
                                    Gap(w: 9)
                                    Image("star")
                                        .aspectRatio(contentMode: .fill)
                                        .containerRelativeFrame(.horizontal) { size, _ in
                                            size * 0.04
                                        }
                                }
                            })
                            .buttonStyle(.borderedProminent)
                            .accentColor(.white)
                        }
                    }
                    .padding(.trailing, 10)
                
                    Gap(h: 20)
                }
                .padding(.horizontal, 10)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
    
    private func moveCards(index: Int){
        withAnimation {
            vm.moveToBack(index, isGetStarted: true)
            if let topCard = vm.cards.first {
                progress = CGFloat(topCard.progress)
            }
        }
       }
    
    private func nearestItemIndex(for midXValues: [CGFloat], in totalWidth: CGFloat) -> Int? {
           let centerX = totalWidth / 2
           let distances = midXValues.enumerated().map { (index, midX) in
               (index, abs(midX - centerX))
           }
           return distances.min(by: { $0.1 < $1.1 })?.0
       }
    
    private func scaleForx(index value: Int) -> Double {
        let index = Double(value)
        if index == 0 {
            return 1.0
        } else if index == 1 {
            return 0.75
        } else if index == 2 {
            return 0.60
        } else {
            return 0.7
        }
    }
    
    func offsetForx(index value: Int)-> Double {
        let index = Double(value )
        if index >= 0 {
            if index > 2 {
                return 20
            }
            return  (index * 40)
        } else{
            if -index > 3 {
                return 30
            }
            return (-index * 10)
        }
     
    }
    
       
    
   
}


