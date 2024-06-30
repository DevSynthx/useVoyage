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
            Text("What are you\ninterested in?")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.black)
                .padding(.leading, 20)
            Gap(h: 15)
            Text("Tell us more about yourself. Select a\nminimum of 3 interests.")
                .font(.system(size: 14, weight: .light))
                .foregroundStyle(.gray)
                .padding(.leading, 20)
            
            Gap(h: 20)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(vm.interests.enumerated().map{$0}.filter{$0.element.selected == true}, id: \.element.name) { v in
                                HStack{
                                    Text(v.element.name)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 14))
                                        .padding(.trailing, 8)
                                    Image(systemName: "xmark")
                                        .font(.system(size: 17))
                                        .foregroundStyle(.white)
                                        .onTapGesture {
                                            select(name: v.element.name)
                                        }
                                       
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 10)
                            .background{
                                RoundedRectangle(cornerRadius: 30)
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
                                    .fill(v.element.selected ?.blue : .clear)
                                    .stroke(.greyX, lineWidth: 3)
                                    .frame(width: 150, height: 140)
                                    .overlay{
                                            VStack{
                                                Image(v.element.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(v.element.selected ?.white : .black)
                                                    .frame(width:  40, height: 40)
                                                
                                                Text(v.element.name)
                                                    .foregroundStyle(v.element.selected ?.white : .black)
                                                    .font(.system(size: 15))
                                                    .padding(.top, 5)

                                            }
                            
                                    }
                                    .onTapGesture{
                                        select(name: v.element.name)
                                    }
                                Image("borderCorner")
                                    .resizable()
                                    .foregroundStyle(v.element.selected ?.green : .greyX)
                                    .frame(width: 30, height: 30)
                                    .overlay{
                                        Image("checkMark")
                                            .resizable()
                                            .foregroundStyle(v.element.selected ? .white : .greyX)
                                            .frame(width: 20, height: 20)
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
                                    .fill(v.element.selected ?.blue : .clear)
                                    .stroke(.greyX, lineWidth: 3)
                                    .frame(width: 150, height: 140)
                                    .overlay{
                                            VStack{
                                                Image(v.element.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(v.element.selected ?.white : .black)
                                                    .frame(width:  40, height: 40)
                                                
                                                Text(v.element.name)
                                                    .foregroundStyle(v.element.selected ?.white : .black)
                                                    .font(.system(size: 15))
                                                    .padding(.top, 5)

                                            }
                            
                                    }
                                    .onTapGesture{
                                        select(name: v.element.name)
                                    }
                                Image("borderCorner")
                                    .resizable()
                                    .foregroundStyle(v.element.selected ?.green : .greyX)
                                    .frame(width: 30, height: 30)
                                    .overlay{
                                        Image("checkMark")
                                            .resizable()
                                            .foregroundStyle(v.element.selected ? .white : .greyX)
                                            .frame(width: 20, height: 20)
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
                                    .fill(v.element.selected ?.blue : .clear)
                                    .stroke(.greyX, lineWidth: 3)
                                    .frame(width: 150, height: 140)
                                    .overlay{
                                            VStack{
                                                Image(v.element.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(v.element.selected ?.white : .black)
                                                    .frame(width:  40, height: 40)
                                                
                                                Text(v.element.name)
                                                    .foregroundStyle(v.element.selected ?.white : .black)
                                                    .font(.system(size: 15))
                                                    .padding(.top, 5)

                                            }
                            
                                    }
                                    .onTapGesture{
                                        select(name: v.element.name)
                                    }
                                Image("borderCorner")
                                    .resizable()
                                    .foregroundStyle(v.element.selected ?.green : .greyX)
                                    .frame(width: 30, height: 30)
                                    .overlay{
                                        Image("checkMark")
                                            .resizable()
                                            .foregroundStyle(v.element.selected ? .white : .greyX)
                                            .frame(width: 20, height: 20)
                                    }
                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                         
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .padding(.leading, 40)
            }
            .defaultScrollAnchor(.center)
            

            HStack{
                Text("\(vm.interests.filter{$0.selected == true}.count) Interests selected")
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .padding(13)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                    }
                    .onTapGesture{
                        router.push(to: .CityVisited)
                    }
            }
            .padding(.bottom, 20)
            .padding(.top, 20)
            .padding(.horizontal, 20)
           // .frame(maxWidth: .infinity, maxHeight: .infinity)
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
