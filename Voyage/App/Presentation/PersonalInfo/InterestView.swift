//
//  IntersectView.swift
//  project-z
//
//  Created by Inyene Etoedia on 22/06/2024.
//

import SwiftUI

struct InterestView: View {
    @EnvironmentObject var vm: PersonalInfoVM
    @EnvironmentObject var router: Router<Routes>
    @State private var rectSize: CGSize = .zero
    @State private var countOffset: CGFloat = 70
    @State private var showCount: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Gap(h: 25)
            Text("What are you\ninterested in?")
                .font(.custom(.bold, size: 30))
                .foregroundStyle(.black)
                .padding(.leading, 20)
            Gap(h: 15)
            Text("Tell us more about yourself. Select a\nminimum of 3 interests.")
                .font(.custom(.light, size: 14))
                .lineSpacing(5)
                .foregroundStyle(.gray)
                .padding(.leading, 20)
            
            Gap(h: 20)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(vm.interests.enumerated().map{$0}.filter{$0.element.selected == true}, id: \.element.name) { v in
                                HStack{
                                    Text(v.element.name)
                                        .font(.custom(.regular, size: 14))
                                        .foregroundStyle(.white)
                                        .padding(.trailing, 8)
                                    Image(systemName: "xmark")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.white)
                                        .onTapGesture {
                                            select(name: v.element.name)
                                        }
                                       
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 10)
                            .background{
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundStyle(.black)
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
            .opacity(vm.interests.filter{$0.selected == true}.count > 0 ? 1 : 0)
            Gap(h: 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vm.interests.enumerated().map {$0}.filter {$0.offset < 4}, id: \.element.name) { v in
                        HStack{
                            ZStack(alignment: .topTrailing){
                                RoundedRectangle(cornerRadius: 9)
                                    .fill(v.element.selected ?.gray.opacity(0.4) : .clear)
                                    .stroke(.gray.opacity(0.15), lineWidth: 3)
                                    .frame(width: 150, height: 140)
                                    .overlay{
                                            VStack{
                                                Image(v.element.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(.black)
                                                    .frame(width:  40, height: 40)
                                                
                                                Text(v.element.name)
                                                    .font(.custom(.semiBold, size: 15))
                                                    .foregroundStyle(.black)
                                                    .padding(.top, 5)

                                            }
                            
                                    }
                                    .onTapGesture{
                                        select(name: v.element.name)
                                    }
                                if(v.element.selected){
                                    Image("borderCorner")
                                        .resizable()
                                        .colorMultiply(.green)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }else{
                                    Image("borderCorner")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }
                                
                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                         
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .padding(.horizontal, 40)
            }
            .defaultScrollAnchor(.center)
            Gap(h: 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vm.interests.enumerated().map {$0}.filter {$0.offset >= 4 && $0.offset < 8 }, id: \.element.name) { v in
                        HStack{
                            ZStack(alignment: .topTrailing){
                                RoundedRectangle(cornerRadius: 9)
                                    .fill(v.element.selected ?.gray.opacity(0.4) : .clear)
                                    .stroke(.gray.opacity(0.15), lineWidth: 3)
                                    .frame(width: 150, height: 140)
                                    .overlay{
                                            VStack{
                                                Image(v.element.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(.black)
                                                    .frame(width:  40, height: 40)
                                                
                                                Text(v.element.name)
                                                    .font(.custom(.semiBold, size: 15))
                                                    .foregroundStyle(.black)
                                                    .padding(.top, 5)

                                            }
                            
                                    }
                                    .onTapGesture{
                                        select(name: v.element.name)
                                    }
                                if(v.element.selected){
                                    Image("borderCorner")
                                        .resizable()
                                        .colorMultiply(.green)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }else{
                                    Image("borderCorner")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }
                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                         
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .padding(.horizontal, 40)
            }
            .defaultScrollAnchor(.center)
            Gap(h: 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vm.interests.enumerated().map {$0}.filter { $0.offset >= 8 }, id: \.element.name) { v in
                        HStack{
                            ZStack(alignment: .topTrailing){
                                RoundedRectangle(cornerRadius: 9)
                                    .fill(v.element.selected ?.gray.opacity(0.4) : .clear)
                                    .stroke(.gray.opacity(0.15), lineWidth: 3)
                                    .frame(width: 150, height: 140)
                                    .overlay{
                                            VStack{
                                                Image(v.element.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(.black)
                                                    .frame(width:  40, height: 40)
                                                
                                                Text(v.element.name)
                                                    .font(.custom(.semiBold, size: 15))
                                                    .foregroundStyle(.black)
                                                    .padding(.top, 5)

                                            }
                            
                                    }
                                    .onTapGesture{
                                        select(name: v.element.name)
                                    }
                                if(v.element.selected){
                                    Image("borderCorner")
                                        .resizable()
                                        .colorMultiply(.green)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }else{
                                    Image("borderCorner")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }
                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                         
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .padding(.leading, 40)
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, 20)
            .scrollTargetBehavior(.viewAligned)
            .defaultScrollAnchor(.center)
            

            HStack{
                Text("\(vm.interests.filter{$0.selected == true}.count) Interests selected")
                    .font(.custom(.medium, size: 18))
                    .foregroundStyle(.black)
                Spacer()
                NextButton(color: vm.interests.filter{$0.selected == true}.count > 3 ? .black : .gray.opacity(0.3),
                action: {
                        if(vm.interests.filter{$0.selected == true}.count > 3 ){
                            router.push(to: .CityVisited)
                        }
                })

            }
            .padding([.horizontal, .vertical], 20)
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
        .ignoresSafeArea(.all, edges: .bottom)
        .background(.white)
        .navigationBarBackButtonHidden(true)
    }
    
    private func select(name: String ){
        vm.selectInterest(name: name)
        withAnimation(.smooth) {
            if(vm.interests.filter{$0.selected == true}.count > 0){
                countOffset = 40
                showCount = true
            } else{
                countOffset = 40
                showCount = false
            }
        }
    }
}

#Preview {
    InterestView()
        .environmentObject(PersonalInfoVM())
}
