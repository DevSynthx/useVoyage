//
//  CityVisited.swift
//  project-z
//
//  Created by Inyene Etoedia on 23/06/2024.
//

import SwiftUI

struct CityVisited: View {
    @FocusState var isFocused: Bool
    @EnvironmentObject var vm: PersonalInfoVM
    @EnvironmentObject var router: Router<Routes>
    @State private var countOffset: CGFloat = 70
    @State private var showCount: Bool = false
    @State var text: String = ""
    @State var showSearch: Bool = false
    @Namespace var nameSpace
    @State private var contentHeight: CGSize = .zero
    var body: some View {
        
        GeometryReader { geo in
            let size = geo.size
            ZStack (alignment: .top){
                Color.white
                if !showSearch {
                    VStack(spacing: 0){
                      
                        Group{
                            Gap(h:size.height / 20 )
                            Text("What cities have\nyou visited?")
                                .font(.custom(.bold, size: 30))
                                .foregroundStyle(.black)
                                .padding(.leading, 20)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            Gap(h: 30)
                            VStack(alignment: .leading){
                                HStack{
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.gray)
                                    Text("Search city")
                                        .foregroundStyle(.gray)
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                
                            }
                            .padding(.leading, 13)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background{
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.white)
                                    .stroke(.gray, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                    .frame(height: 40)
                                
                            }
                            .matchedGeometryEffect(id: "textfield", in: nameSpace, isSource: true)
                            .matchedGeometryEffect(id: "show", in: nameSpace, isSource: true)
                            .animation(.spring, value: showSearch)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                withAnimation {
                                    showSearch.toggle()
                                }
                            }

                        }
                        

                        if(!vm.selectedCities.isEmpty){
                            Gap(h: 30)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(vm.selectedCities.enumerated().map{$0}, id: \.element.name) { v in
                                        HStack{
                                            Circle()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.black)
                                            Gap(w: 10)
                                            Text(v.element.name)
                                                .font(.custom(.regular, size: 14))
                                                .foregroundStyle(.black)
                                            
                                        }
                                        .padding(10)
                                        .background{
                                            RoundedRectangle(cornerRadius: 40)
                                                .fill(.clear)
                                                .stroke(.gray.opacity(0.2), lineWidth: 2)
                                        }
                                        .overlay(
                                            GeometryReader { geo in
                                                Color.clear
                                                    .updateSized(geo.size)
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal, 20)
                                .onPreferenceChange(HeightPreferenceKey.self, perform: { value in
                                    self.contentHeight = value
                                })
                            }
                            .frame(height: contentHeight.height)
                            .overlay(
                                GeometryReader { geo in
                                    Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size)
                                }
                            )
                        } else{
                            Gap(h: size.height * 0.07)
                            Text("Your selected cities will appear below")
                                .font(.custom(.regular, size: 16))
                                .foregroundStyle(.gray)
                            Gap(h: size.height * 0.03)
                        }
                        
                        Image("map")
                            .frame(maxWidth: UIScreen.main.bounds.width) 
                            .overlay{
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack{
                                        ForEach(vm.selectedCities.enumerated().map{$0}, id: \.element.name) { v in
                                            
                                            ZStack(alignment: .top){
                                                
                                                VStack{
                                                    Image("image")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .containerRelativeFrame(.horizontal, { size, axis in
                                                            size * 0.55
                                                        })
                                                        .clipShape( UnevenRoundedRectangle(cornerRadii: .init(topLeading: 15, topTrailing: 15)))
                                                    HStack{
                                                        Text(v.element.name)
                                                            .font(.custom(.regular, size: 15))
                                                            .foregroundColor(.black)
                                                        Spacer()
                                                        Image(systemName: "xmark.circle")
                                                            .foregroundStyle(.red)
                                                            .onTapGesture {
                                                                vm.removeCity(city: v.element)
                                                            }
                                                    }
                                                    .padding(.vertical, 10)
                                                    
                                                }
                                                .padding([.horizontal, .vertical], 10)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .foregroundStyle(.white)
                                                }
                                                Image("clip")
                                                    .offset(y: -10)
                                            }
                                            .rotationEffect(.degrees(v.offset % 2 == 0 ? 3 : -3))
                                            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                            .padding(.horizontal, 10)
                                            .scrollTransition(.interactive, axis: .horizontal){
                                                view, phase in
                                                view.scaleEffect(phase.isIdentity ? 1 : 0.85)
                                                    .rotation3DEffect(.degrees(phase.value * -10), axis: (x: 0, y: 0, z: 1))
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                        
                        Spacer()
                        HStack{
                            Text("\(vm.selectedCities.count) Cities selected")
                                .font(.custom(.medium, size: 18))
                                .foregroundStyle(.black)
                            Spacer()
                            NextButton {
                                router.push(to: .TripType)
                            }
                        }
                        .padding(.bottom, 30)
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        .background {
                            Rectangle()
                                  .foregroundStyle(.white)
                                  .shadow(color: .gray.opacity(0.1), radius: 3.5, y: -5)
                        }
                        .opacity(vm.selectedCities.count > 0 ? 1 : 0)
                    }
                }
                else{
                    SearchView(namespace: nameSpace, action: {
                        withAnimation(.spring) {
                            showSearch.toggle()
                        }
                    })
                
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width,   maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(.white)
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    CityVisited()
        .environmentObject(PersonalInfoVM())
        .environmentObject(Router(root: Routes.TripType))
}


struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func updateSized(_ size: CGSize) -> some View {
        preference(key: HeightPreferenceKey.self, value: size)
    }
}
