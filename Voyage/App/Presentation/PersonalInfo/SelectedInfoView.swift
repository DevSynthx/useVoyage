//
//  SelectedInfoView.swift
//  Voyage
//
//  Created by Inyene Etoedia on 30/06/2024.
//

import SwiftUI

class CardXVM : ObservableObject {
    @Published var cards: [(String,CGFloat, Color)]  = [
        ("water", 0, .red), ("Fruits", 0, .green), ("Sugar", 0, .blue), ("Apples", 0, .yellow)
    ]
    @Published var swipedCard = 0
    
    func update(card: (String,CGFloat, Color)){
       // self.cards.insert( card, at: cards.count)
    }
}

struct SelectedInfoView: View {
    @StateObject private var cardVm = CardXVM()
    var width = UIScreen.main.bounds.width
    var body: some View {
        VStack {
           //CardView()
            BoomerangeCard()
                .frame(height: 220)
                .padding(.horizontal, 10)
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
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottom)
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
    SelectedInfoView()
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
            .offset(x: offsetForx(index: index))
            .offset(x: card.extraOffset)
            .scaleEffect(scaleForx(index: index), anchor: .top)
            .zIndex(card.zIndex)
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
