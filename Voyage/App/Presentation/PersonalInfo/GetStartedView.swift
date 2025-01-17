//
//  SelectedInfoView.swift
//  Voyage
//
//  Created by Inyene Etoedia on 30/06/2024.
//

import SwiftUI



struct CardA {
   // let id: Int
    let color: Color
    
    var view: some View {
        VStack{
            Image("personalityIcon")
            Gap(h: 10)
            Text("get started")
                .font(.customx(.regular, size: 12))
                .foregroundStyle(.black)
        }
        .frame(width: 100, height: 115)
        .background{
            Rectangle()
                .fill(color)
                .frame(width: 100, height: 115)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
        }
       
    }
}

class CardXVM : ObservableObject {
    @Published var cards: [(String,CGFloat, Color)]  = [
        ("water", 0, .red), ("Fruits", 0, .green), ("Sugar", 0, .blue), ("Apples", 0, .yellow)
    ]
    @Published var swipedCard = 0
    
    func update(card: (String,CGFloat, Color)){
       // self.cards.insert( card, at: cards.count)
    }
}

struct GetStartedView: View {
    @StateObject private var cardVm = CardXVM()
    @EnvironmentObject var vm: PersonalInfoVM
    @Environment(\.router) var router
    var width = UIScreen.main.bounds.width
    @State var currentIndex : Int = 0
    @State private var progress: CGFloat = 20.0
    @State private var contentHeight: CGSize = .zero
    let text = "We have\nmapped out\nthe perfect\ngetaway for you"
    let textB = "Choose a\ncategory to\nget started"


    var body: some View {
     
        GeometryReader(content: { geo in
            let size = geo.size
            ZStack(alignment: .top) {
            
                VStack{
                    VStack {
                        Gap(h: 10)
                        Image("plane_icon")
                            .containerRelativeFrame(.horizontal, { size, _ in
                                size / 20
                            })
                            .frame(maxWidth: .infinity, alignment: . trailing)
                            .padding(.trailing, 40)
                        Gap(h: 15)
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
                                     // CardA(color: card.color, progress: card.progress)
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
                                .font(.customx(.bold, size: 16))
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
                        Gap(h: vm.selectedTrip.ticketCount != 0 ? 10 : 25)
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
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 25)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(
                                               gradient: Gradient(colors: [Color(hex: "FF87C7"), Color(hex: "48ACF0")]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing))
                           .padding(.horizontal, 25)
                    }
                    .padding(.top, 25)

                    Gap(h: 10)
                    Image("screen_buttons")
                         .resizable()
                         .scaledToFit()
                         .padding(.horizontal, 24)
                         .padding(.bottom, 5)
                    Gap(h: 7)
                }
                .background{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.black)
                }
                .offset(y: size.height / 6)
            
            //vm.selectedTrip.ticketCount
                ZStack(alignment: .center){
               
                        ForEach(Array(0..<vm.selectedTrip.ticketCount), id: \.self) { v in
                            Image(vm.selectedTrip.ticketType == "" ? "planeTicket" : vm.selectedTrip.ticketType)
                                .resizable()
                                .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                                    size / 2.7
                                }
                                .rotationEffect(.degrees(v == 0 ? -15 : (v == 1 ? -15 : (v == 2 ? 10 : 5))), anchor: .center)
                                .offset(x: v == 0 ? 50 : (v == 1 ? -10 : (v == 2 ? 35 : 20)) , y: -110)

                        }
                    
                  //  .frame(height: 100)
                    
                   
                    Image("hand")
                        .containerRelativeFrame(.horizontal) { size, _ in
                            size / 3
                        }
                    
                    Text(vm.username.truncate(7))
                        .font(.customx( .bold, size: 20))
                        .foregroundStyle(.passportText)
                        .rotationEffect(Angle(degrees: -20))
                        .offset(y: -140)
                    
                }
                .offset(y: size.height / 2.2)
                
                   
               
              // CardView()
    //            BoomerangeCard()
    //                .frame(height: 220)
    //                .padding(.horizontal, 10)
    //            ZStack{
    //                ForEach(cardVm.cards.indices.reversed(), id: \.self) { v in
    //                    HStack {
    //                        Rectangle()
    //                            .fill( cardVm.cards[v].2)
    //                            .frame(width: getCardWidth(index: v), height: getCardHeight(index: v))
    //                            .cornerRadius(8)
    //                            .shadow(radius: 4)
    //                            .offset(x: getOffset(index: v))
    //                            .rotationEffect(.init(degrees: getRotation(index: v)))
    //
    //                    }
    //                    .contentShape(Rectangle())
    //                    .offset(x: cardVm.cards[v].1)
    //                    .gesture(
    //                      DragGesture(minimumDistance: 0)
    //                        .onChanged({ value in
    //                            onChange(value: value, index: v)
    //                        })
    //                        .onEnded({ valuex in
    //                            onEnd(value: valuex, index: v)
    //                        })
    //
    //                    )
    //                }
    //            }
            }
            .padding(25)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .top)
            .navigationBarBackButtonHidden(true)

        })
        .background{
            Image("backseat")
                .scaledToFill()
                  
        }
        .ignoresSafeArea(.all)
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
    
       
    
     func onChange(value: DragGesture.Value, index: Int){
        if value.translation.width < 0 {
            cardVm.cards[index].1 = value.translation.width
        }
    }
    
     func onEnd(value: DragGesture.Value, index: Int){
         withAnimation {
             if -value.translation.width > width / 2 {
                 cardVm.cards[index].1 = -width
                 cardVm.update(card: cardVm.cards[index])
                cardVm.swipedCard += 1
             }
              else {
                  cardVm.cards[index].1 = 0
             }
         }
    }
    
    func getRotation(index: Int)-> Double{
        let boxWidth = Double(width / 3)
        let offset = Double(cardVm.cards[index].1)
        let angle : Double = 5
        return (offset / boxWidth) * angle
    }
    
    func getCardHeight(index: Int)-> CGFloat{
        let height : CGFloat = 200
        let cardHeight = index - cardVm.swipedCard <= 2 ? CGFloat(index - cardVm.swipedCard) * 35 : 70
        return height - cardHeight
    }
    
    func getCardWidth(index: Int)-> CGFloat{
        let boxWidth = UIScreen.main.bounds.width - 100 - 100
        let cardHeight = index <= 2 ? CGFloat(index) * 9 : 70
        return boxWidth - cardHeight
    }
    
    func getOffset(index: Int)-> CGFloat {
        index - cardVm.swipedCard <= 2 ? CGFloat(index - cardVm.swipedCard) * 20 : 40
    }
}

#Preview {
    GetStartedView()
        .environmentObject(PersonalInfoVM())
}



struct CardViewX : View {
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    @State var cards: [Card] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                ForEach(cards.reversed()) { v in
                    let index = indexOf(card: v)
                     Rectangle()
                        .foregroundColor(v.color)
                        .frame(width: 150, height: 200)
                        .scaleEffect(v.scale)
                        .offset(x: offsetFor(index: index))
                        .offset(y: v.extraOffset)
                        .offset(x: currentIndex == indexOf(card: v) ? offset : 0)
                        .scaleEffect(scaleFor(index: index), anchor: .center)
                        .zIndex(v.zIndex)
                
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: offset == .zero)
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
            DragGesture(minimumDistance: 2)
                .onChanged(onChange(value:))
                .onEnded(onEnd(value:))
            )
            .onAppear{
                setup()
            }
        }
    }
    
    
    
   func onChange(value: DragGesture.Value){
       offset = currentIndex == (cards.count - 1) ? 0 :  value.translation.width
    }
    
    func onEnd(value: DragGesture.Value){
        var translation = value.translation.width
        translation = (translation < 0 ? -translation : 0)
        translation = (currentIndex == (cards.count - 1) ? 0 : translation)
        if translation > 110 {
            withAnimation {
                cards[currentIndex].isRotated = true
                cards[currentIndex].extraOffset = -250
                cards[currentIndex].scale = 0.2
            }
            // A Little Delay Resetting Gesture offset and Extra Offset
            // Pushing Card to the back using Z-Index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                cards[currentIndex].zIndex = -100
                for index in cards.indices {
                    cards[index].extraOffset = 0
                }
                if currentIndex != (cards.count - 1){
                    currentIndex += 1
                }
                offset = .zero
            }
            
            // After Animation completed, Resetting Rotation and Scaling and setting Proper Z-Index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
                for index in cards.indices {
                    if index == currentIndex {
                       // MARK: Placing the card at Right Index
                      // NOTE since the current index is updated + 1 previously
                     // So the current index will be -1 Now
                        if cards.indices.contains(currentIndex - 1){
                            cards[currentIndex - 1].zIndex = Zindex(card: cards[currentIndex - 1])
                        }
                    }
                    else {
                        cards[index].isRotated = false
                        cards[index].scale = 1
                    }
                }
                
                if currentIndex == (cards.count - 1){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                        for index in cards.indices {
                            cards[index].zIndex = 0
                        }
                        currentIndex = 0
                    }
                }
            }
            
        } else {
            offset = .zero
        }
  
     }
    
    func Zindex(card: Card)-> Double{
        let index = indexOf(card: card)
        let totalCount = cards.count
        return currentIndex > index ? Double(index - totalCount) : cards[index].zIndex
    }
    
    func scaleFor(index value: Int)-> Double {
        let index = Double(value - currentIndex)
        if index >= 0 {
            if index > 3 {
                return 0.8
            }
            return 1 - (index / 13)
        } else {
            if -index > 3 {
                return 0.8
            }
            return 1 + (index / 10)
        }
    }
    
    func offsetFor(index value: Int)-> Double {
        let index = Double(value - currentIndex)
        if index >= 0 {
            if index > 3 {
                return 30
            }
            
            return  (index * 35)
        } else {
            if -index > 3 {
                return 30
            }
            
            return  (-index * 10)
        }
        
    }
    
    func indexOf(card : Card) -> Int {
        if let index = cards.firstIndex(where: { cCard in
            cCard.id == card.id
        }){
            return index
        }
        return 0
    }
    
    func setup(){
         let colors = [
            Color.red,
            Color.blue,
            Color.green,
            Color.yellow
        ]
        for index in colors {
            cards.append(.init(color: index))
            
        }
        
        if var first = cards.first {
            first.id = UUID().uuidString
            cards.append(first)
        }
    }
     
}


struct BoomerangeCard: View {
    var isRotation: Bool = false
    var isBlur: Bool = false
    @State var cards: [Card] = []
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack{
                ForEach(cards.reversed()) { card in
                    CardView(card: card, size: size)
                        .offset(y: currentIndex == indexOfx(card: card) ? offset : 0)
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: offset == .zero)
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 2)
                    .onChanged(onChange(value:))
                    .onEnded(onEnd(value:))
            )
            .onAppear(perform: setup )
        }
    }
    
    func onChange(value: DragGesture.Value){
        offset = value.translation.height
     }
     
     func onEnd(value: DragGesture.Value){
         var translation =  value.translation.height
         //MARK: Since we only need negative numbers
         translation = (translation < 0 ? -translation : 0)
         //MARK: Since our card height is 220
         if translation > 110 {
         //MARK: Doing Boomerang effect and updating current index
             withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
            //MARK: Applying Rotation effect and updating Extra Offset
                 cards[currentIndex].isRotated = true
                 cards[currentIndex].extraOffset = -250
                 cards[currentIndex].scale = 0.7
             }
             
             // After a Little Delay Resetting Gesture Offset and Extra Offset
             // Pushing Card into back using ZIndex
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                 withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                //MARK: Applying Rotation effect and updating Extra Offset
                     cards[currentIndex].zIndex = -100
                     for index in cards.indices {
                         cards[index].extraOffset = 0
                     }
               //MARK: Updating current index
                     if currentIndex != (cards.count - 1){
                         currentIndex += 1
                     }
                     offset = .zero
                 }
             }
             //MARK: After Animation Completed Resetting Rotation, Scaling and Setting Proper Zindex Value
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                 for index in cards.indices {
                     if index == currentIndex {
                        //MARK: Placing the cards at the right index
                         if cards.indices.contains(currentIndex - 1){
                             cards[currentIndex - 1].zIndex = Zindex(card: cards[currentIndex - 1])
                         }
                     }
                     else{
                         cards[index].isRotated = false
                         withAnimation {
                             cards[index].scale = 1
                         }
                     }
                 }
                 if currentIndex == (cards.count - 1){
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                         for index in cards.indices {
                             cards[index].zIndex = 0
                         }
                         currentIndex = 0
                     }
                 }
             }
         } else{
             offset = .zero
         }
      }
    
    func Zindex(card: Card)-> Double{
        let index = indexOfx(card: card)
        let totalCount = cards.count
        return currentIndex > index ? Double(index - totalCount) : cards[index].zIndex
    }
    
    @ViewBuilder
    func CardView(card: Card, size: CGSize)-> some View {
        let index = indexOfx(card: card)
         Rectangle()
            .foregroundStyle(card.color)
            .frame(width: size.width, height: size.height )
            .scaleEffect(card.scale, anchor:card.isRotated ? .center : .top)
            .offset(y: -offsetForx(index: index))
            .offset(y: card.extraOffset)
            .scaleEffect(scaleForx(index: index), anchor: .top)
            .zIndex(card.zIndex)
    }
    
    func setup(){
         let colors = [
            Color.red,
            Color.blue,
            Color.green,
            Color.yellow,
            Color.pink
        ]
        for index in colors {
            cards.append(.init(color: index))
            
        }
        if var first = cards.first {
            first.id = UUID().uuidString
            cards.append(first)
        }
    }
    
    func scaleForx(index value: Int)-> Double {
        let index = Double(value - currentIndex)
        if index >= 0{
            if index > 3 {
                return 0.8
            }
            // For Each Card 0.06 Scale will be reduced
            return 1 - (index / 15)
        } else {
            if -index > 3 {
                return 0.8
            }
            // For Each Card 0.06 Scale will be reduced
            return 1 + (index / 15)
        }
    }
    func offsetForx(index value: Int)-> Double {
        let index = Double(value - currentIndex)
        if index >= 0 {
            if index > 3 {
                return 30
            }
            return  (index * 10)
        } else{
            if -index > 3 {
                return 30
            }
            return (-index * 10)
        }
     
    }
    
    func indexOfx(card : Card) -> Int {
        if let index = cards.firstIndex(where: { CCard in
            CCard.id == card.id
        }){
            return index
        }
        return 0
    }
   
    
}


struct CardView : View {
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    @State var cards: [Card] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                ForEach(cards.reversed()) { v in
                    let index = indexOf(card: v)
                     Rectangle()
                        .foregroundColor(v.color)
                        .frame(width: 150, height: 200)
                        .scaleEffect(v.scale)
                        .offset(x: offsetFor(index: index))
                        .offset(y: v.extraOffset)
                        .offset(x: currentIndex == indexOf(card: v) ? offset : 0)
                        .scaleEffect(scaleFor(index: index), anchor: .center)
                        .zIndex(v.zIndex)
                
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: offset == .zero)
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
            DragGesture(minimumDistance: 2)
                .onChanged(onChange(value:))
                .onEnded(onEnd(value:))
            )
            .onAppear{
                setup()
            }
        }
    }
    
    
    
   func onChange(value: DragGesture.Value){
       offset = currentIndex == (cards.count - 1) ? 0 :  value.translation.width
    }
    
    func onEnd(value: DragGesture.Value){
        var translation = value.translation.width
        translation = (translation < 0 ? -translation : 0)
        translation = (currentIndex == (cards.count - 1) ? 0 : translation)
        if translation > 110 {
            withAnimation {
                cards[currentIndex].isRotated = true
                cards[currentIndex].extraOffset = -250
                cards[currentIndex].scale = 0.2
            }
            // A Little Delay Resetting Gesture offset and Extra Offset
            // Pushing Card to the back using Z-Index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                cards[currentIndex].zIndex = -100
                for index in cards.indices {
                    cards[index].extraOffset = 0
                }
                if currentIndex != (cards.count - 1){
                    currentIndex += 1
                }
                offset = .zero
            }
            
            // After Animation completed, Resetting Rotation and Scaling and setting Proper Z-Index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
                for index in cards.indices {
                    if index == currentIndex {
                       // MARK: Placing the card at Right Index
                      // NOTE since the current index is updated + 1 previously
                     // So the current index will be -1 Now
                        if cards.indices.contains(currentIndex - 1){
                            cards[currentIndex - 1].zIndex = Zindex(card: cards[currentIndex - 1])
                        }
                    }
                    else {
                        cards[index].isRotated = false
                        cards[index].scale = 1
                    }
                }
                
                if currentIndex == (cards.count - 1){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                        for index in cards.indices {
                            cards[index].zIndex = 0
                        }
                        currentIndex = 0
                    }
                }
            }
            
        } else {
            offset = .zero
        }
  
     }
    
    func Zindex(card: Card)-> Double{
        let index = indexOf(card: card)
        let totalCount = cards.count
        return currentIndex > index ? Double(index - totalCount) : cards[index].zIndex
    }
    
    func scaleFor(index value: Int)-> Double {
        let index = Double(value - currentIndex)
        if index >= 0 {
            if index > 3 {
                return 0.8
            }
            return 1 - (index / 13)
        } else {
            if -index > 3 {
                return 0.8
            }
            return 1 + (index / 10)
        }
    }
    
    func offsetFor(index value: Int)-> Double {
        let index = Double(value - currentIndex)
        if index >= 0 {
            if index > 3 {
                return 30
            }
            
            return  (index * 35)
        } else {
            if -index > 3 {
                return 30
            }
            
            return  (-index * 10)
        }
        
    }
    
    func indexOf(card : Card) -> Int {
        if let index = cards.firstIndex(where: { cCard in
            cCard.id == card.id
        }){
            return index
        }
        return 0
    }
    
    func setup(){
         let colors = [
            Color.red,
            Color.blue,
            Color.green,
            Color.yellow
        ]
        for index in colors {
            cards.append(.init(color: index))
            
        }
        
        if var first = cards.first {
            first.id = UUID().uuidString
            cards.append(first)
        }
    }
    
}



struct Card: Identifiable {
    var id: String = UUID().uuidString
                var color: Color
    var isRotated: Bool = false
    var scale: CGFloat = 1
    var extraOffset: CGFloat = 0
    var zIndex: CGFloat = 0
    
    
}
