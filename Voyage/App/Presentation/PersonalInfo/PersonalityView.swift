//
//  SelectPersonalityView.swift
//  project-z
//
//  Created by Inyene Etoedia on 21/06/2024.
//

import SwiftUI

struct PersonalityView: View {
    @EnvironmentObject var vm : PersonalInfoVM
    @EnvironmentObject var router: Router<Routes>
    @State private var rectSize: CGSize = .zero
    @State private var countOffset: CGFloat = 70
    @State private var showCount: Bool = false
    var body: some View {
       
            VStack(alignment: .leading){
                Gap(h: 25)
                Text("What’s your\npersonality?")
                    .font(.custom(.bold, size: 30))
                    .foregroundStyle(.black)
                    .padding(.leading, 20)
                Gap(h: 20)
                Text("Tell us more about yourself. Select a\nminimum of 3 characters.")
                    .font(.custom(.light, size: 15))
                    .lineSpacing(5)
                    .foregroundStyle(.gray)
                    .padding(.leading, 20)
                
                Gap(h: 20)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(vm.personalities.enumerated().map{$0}.filter{$0.element.selected == true}, id: \.element.name) { v in
                                    HStack{
                                        Text(v.element.name)
                                            .font(.custom(.light, size: 13))
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
                //.defaultScrollAnchor(.center)
                .opacity(vm.personalities.filter{$0.selected == true}.count > 0 ? 1 : 0)
                .transition(.move(edge: .top))
                Gap(h: 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vm.personalities.enumerated().map {$0}.filter {$0.offset < 3}, id: \.element.name) { v in
                            HStack{
                                ZStack(alignment: .topTrailing) {
                    
                                    ZStack{
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(.gray.opacity(0.12))
                                                .mask {
                                                    Rectangle()
                                                        .foregroundStyle(.red.opacity(0.78))
                                                        .containerRelativeFrame([.horizontal], { size, axis in
                                                            size * 0.9
                                                        })
                                                        .rotationEffect(.degrees(-23))
                                                        .offset(  y: 40)
                                                        .clipShape(Rectangle())
                                                }
                                        }
                                        
                                        VStack{
                                            Text(v.element.name)
                                                .foregroundStyle(.black)
                                                .font(.custom(.regular, size: 18))
                                                .padding(.leading, 15)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.top, 20)
                                            Image(v.element.image)
                                            //.resizable()
                                                .frame(width:  100, height: 100)
                                                .padding(.trailing, 10)
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                .offset( x: 0, y: 0)
                                        }
                                        
                                        
                                    }
                                    .frame(height: 130)
                                    .containerRelativeFrame([.horizontal], { size, axis in
                                        size * 0.7
                                    })
                                    .background {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.gray.opacity(0.05))
                                }
                                
                                    Image("cornerShape")
                                        .resizable()
                                        .foregroundStyle(v.element.selected ?.green : .white)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }
                                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topTrailing: 8)))
                                .onTapGesture {
                                    select(name: v.element.name )
                                }
                             
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                    .scrollTargetLayout()
                }
                .safeAreaPadding(.horizontal, 20)
                .scrollTargetBehavior(.viewAligned)
                .defaultScrollAnchor(.center)
                Gap(h: 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vm.personalities.enumerated().map {$0}.filter {$0.offset >= 3 && $0.offset < 6 }, id: \.element.name) { v in
                            HStack{
                                ZStack(alignment: .topTrailing) {
                    
                                        ZStack{
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .fill(.gray.opacity(0.12))
                                                    .mask {
                                                        Rectangle()
                                                            .foregroundStyle(.red.opacity(0.78))
                                                            .containerRelativeFrame([.horizontal], { size, axis in
                                                                size * 0.9
                                                            })
                                                         .rotationEffect(.degrees(-23))
                                                         .offset(  y: 40)
                                                         .clipShape(Rectangle())
                                                    }
                                            }
                                            
                                            VStack{
                                                Text(v.element.name)
                                                    .font(.custom(.regular, size: 18))
                                                    .foregroundStyle(.black)
                                                    .padding(.leading, 15)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.top, 20)
                                                Image(v.element.image)
                                                    //.resizable()
                                                    .frame(width:  100, height: 100)
                                                    .padding(.trailing, 10)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    .offset( x: 0, y: 0)
                                            }
                                         

                                        }
                                        .frame(height: 130)
                                    .containerRelativeFrame([.horizontal], { size, axis in
                                        size * 0.7
                                    })
                                    .background {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.gray.opacity(0.05))
                                }
                                
                                    Image("cornerShape")
                                        .resizable()
                                        .foregroundStyle(v.element.selected ?.green : .white)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }
                                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topTrailing: 8)))
                                .onTapGesture {
                                    select(name: v.element.name )
                                }
                               
                                /*
                                ZStack(alignment: .topTrailing){
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.greyX)
                                        .frame(width: 250, height: 150)
                                        .overlay{
                                            ZStack{
                                                Rectangle()
                                                    .foregroundStyle(.gray.opacity(0.08))
                                                 .frame(width: 150, height: 450)
                                                 .offset(x: -10,  y: 90)
                                                 .rotationEffect(.degrees(70))
                                                 .offset(x: 50,  y: 30)
                                                VStack(alignment: .leading){
                                                    Text(v.element.name)
                                                        .foregroundStyle(.black)
                                                        .font(.system(size: 20))
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding(.top, 35)
                                                        .padding(.leading, 15)
                                                    Image(v.element.image)
                                                        //.resizable()
                                                        .frame(width:  120, height: 120)
                                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                                        .offset( x: -10, y: 0)
                                                        
                                                    
                                                }
                                            }

                                        }
                                        .onTapGesture{
                                            select(name: v.element.name)
                                        }
                                    Image("cornerShape")
                                        .resizable()
                                        .foregroundStyle(v.element.selected ?.green : .white)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                    
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 9))
                                
                                */
                             
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                    .scrollTargetLayout()
                }
                .safeAreaPadding(.horizontal, 20)
                .scrollTargetBehavior(.viewAligned)
                .defaultScrollAnchor(.center)
                Gap(h: 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vm.personalities.enumerated().map {$0}.filter { $0.offset >= 6 }, id: \.element.name) { v in
                            HStack{
                                ZStack(alignment: .topTrailing) {
                    
                                        ZStack{
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .fill(.gray.opacity(0.12))
                                                    .mask {
                                                        Rectangle()
                                                            .foregroundStyle(.red.opacity(0.78))
                                                            .containerRelativeFrame([.horizontal], { size, axis in
                                                                size * 0.9
                                                            })
                                                         .rotationEffect(.degrees(-23))
                                                         .offset(  y: 40)
                                                         .clipShape(Rectangle())
                                                    }
                                            }
                                            
                                            VStack{
                                                Gap(h: 30)
                                                Text(v.element.name)
                                                    .font(.custom(.regular, size: 18))
                                                    .foregroundStyle(.black)
                                                    .padding(.leading, 15)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                  
                                                Image(v.element.image)
                                                  .frame(width:  100, height: 100)
                                                    .padding(.trailing, 10)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    
                                            }
                                         

                                        }
                                        .frame(height: 130)
                                    .containerRelativeFrame([.horizontal], { size, axis in
                                        size * 0.7
                                    })
                                    .background {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.gray.opacity(0.05))
                                        }
                                
                                    Image("cornerShape")
                                        .resizable()
                                        .foregroundStyle(v.element.selected ?.green : .white)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            Image("checkMark")
                                                .resizable()
                                                .foregroundStyle(v.element.selected ? .white : .greyX)
                                                .frame(width: 20, height: 20)
                                        }
                                }
                                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topTrailing: 8)))
                                .onTapGesture {
                                    select(name: v.element.name )

                                }
                             
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                    .scrollTargetLayout()
                }
                .safeAreaPadding(.horizontal, 20)
                .scrollTargetBehavior(.viewAligned)
                .defaultScrollAnchor(.center)
                
                HStack{
                    Text("\(vm.personalities.filter{$0.selected == true}.count) Personalities selected")
                        .font(.custom(.medium, size: 18))
                        .foregroundStyle(.black)
                    Spacer()
                    NextButton(color: vm.personalities.filter{$0.selected == true}.count >= 3 ? .black : .gray.opacity(0.3),
                    action: {
                            if(vm.personalities.filter{$0.selected == true}.count >= 3 ){
                                router.push(to: .ComplimentView)
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
        vm.selectPersonalities(name: name)
        withAnimation(.smooth) {
            if(vm.personalities.filter{$0.selected == true}.count > 0){
                countOffset = 40
                showCount = true
            } else{
                countOffset = 70
                showCount = false
            }
        }
    }
}

#Preview {
    PersonalityView()
        .environmentObject(PersonalInfoVM())
        .environmentObject(Router(root: Routes.AuthView))
    
}


struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
