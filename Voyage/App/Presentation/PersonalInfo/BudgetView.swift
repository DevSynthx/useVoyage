//
//  BudgetView.swift
//  project-z
//
//  Created by Inyene Etoedia on 26/06/2024.
//

import SwiftUI

struct BudgetView: View {
    @EnvironmentObject var vm: PersonalInfoVM
    @EnvironmentObject var router: Router<Routes>
    @State var scrollToIndex: Int = 0
    @State private var celsius: Double = 0
    @State private var contentHeight: CGSize = .zero
    @State private var sliderValue: Double = 0
    var body: some View {
        VStack {
            GeometryReader { geo in
                let size = geo.size
                VStack(alignment: .leading){
                    Gap(h: 25)
                    Text("What is your\ndaily budget?")
                        .font(.custom(.bold, size: 30))
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    Gap(h: 15)
                    Text("Choose your daily budget range")
                        .font(.custom(.light, size: 15))
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                    Gap(h: 35)
                    ScrollView(.horizontal, showsIndicators: false)  {
                        ScrollViewReader { proxy in
                            HStack(spacing: 20){
                                ForEach(vm.budgetTypes.enumerated().map{$0}, id: \.element.name) { v in
                                    VStack{
                                        Image(v.element.image)
                                        Gap(h: 20)
                                        Text(v.element.image.capitalized)
                                            .font(.custom(.semiBold, size: 25))
                                            .foregroundStyle(.black)
                                        Gap(h: 15)
                                        Text(v.element.name)
                                            .font(.custom(.regular, size: 15))
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    .frame(height: size.height / 3.5)
                                    .frame(width: size.width)
                                    .background{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.shadow(.inner(radius: 4, y: 1)))
                                            .foregroundStyle(.gray.opacity(0.1))
                                            .padding(.horizontal, 30)
                                    }
                                    .id(v.offset)
                                    .onTapGesture {
                                        proxy.scrollTo(v.offset, anchor: .center)
                                    }
                                  
                                }
                                .onChange(of: scrollToIndex) { oldValue, newValue in
                                    withAnimation(.spring()) {
                                proxy.scrollTo(newValue, anchor: .center)
                                  }
                                }
                            }
                            .scrollTargetLayout()
                           
                        }
                        
                    }
                    .scrollClipDisabled()
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Gap(h: size.height / 12)
                        CustomSliderX(sliderValue: $sliderValue, width: size.width / 1.3)
                            .onChange(of: sliderValue) { oldValue, newValue in
                                switch (Int(sliderValue)){
                                    case 0:
                                        scrollToIndex = 0
                                    case 50:
                                       scrollToIndex = 1
                                    default:
                                        scrollToIndex = 2
                                }
                            
                            }
                            .padding(.bottom, 40)

                    Gap(h: size.height / 9)
                    Text("DRAG TO SELECT YOUR RANGE")
                        .font(.custom(.regular, size: 15))
                        .foregroundStyle(.black)
                        .kerning(5.0)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    Gap(h: size.height / 12)
                    
                    HStack{
                        Text("\(vm.budgetTypes[scrollToIndex].image.capitalized) selected")
                            .font(.custom(.medium, size: 18))
                            .foregroundStyle(.black)
                        Spacer()
                        NextButton {
                        router.push(to: .ChooseSeasonView)
                        }
                       
                    }
                    
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
                    .padding(.top, 20)
                    .background {
                        Rectangle()
                              .foregroundStyle(.white)
                              .shadow(color: .gray.opacity(0.1), radius: 3.5, y: -5)
                    }
                    .offset(y: size.height / 20)
                    .opacity(1)
                    .transition(.move(edge: .bottom))
                                            
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .navigationBarBackButtonHidden(true)
                
            }
            
        }
        .background(.white)
     
       
       
      
    }
}

#Preview {
    BudgetView()
        .environmentObject(PersonalInfoVM())
        .environmentObject(Router(root: Routes.TripType))
}
