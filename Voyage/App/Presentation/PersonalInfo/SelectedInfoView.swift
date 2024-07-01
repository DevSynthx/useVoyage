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
            ZStack{
                ForEach(cardVm.cards.indices.reversed(), id: \.self) { v in
                    HStack {
                        Rectangle()
                            .fill( cardVm.cards[v].2)
                            .frame(width: getCardWidth(index: v), height: getCardHeight(index: v))
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .offset(x: getOffset(index: v))
                            .rotationEffect(.init(degrees: getRotation(index: v)))
                        
                    }
                    .contentShape(Rectangle())
                    .offset(x: cardVm.cards[v].1)
                    .gesture(
                      DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                            onChange(value: value, index: v)
                        })
                        .onEnded({ valuex in
                            onEnd(value: valuex, index: v)
                        })
                    
                    )
                }
            }
        }
    }
    
    
     func onChange(value: DragGesture.Value, index: Int){
        if value.translation.width < 0 {
            cardVm.cards[index].1 = value.translation.width
        }
    }
    
     func onEnd(value: DragGesture.Value, index: Int){
         withAnimation {
             if -value.translation.width > width / 3 {
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
