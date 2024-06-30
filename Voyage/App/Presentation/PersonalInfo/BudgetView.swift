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
                    //Gap(h:size.height / 30 )
                    Text("What is your\ndaily budget?")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    Gap(h: 15)
                    Text("Choose your daily budget range")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false)  {
                        ScrollViewReader { proxy in
                            HStack(spacing: 20){
                                ForEach(vm.budgetTypes.enumerated().map{$0}, id: \.element.name) { v in
                                    VStack{
                                        Image(v.element.image)
                                        Gap(h: 20)
                                        Text(v.element.image.capitalized)
                                            .font(.system(size: 25, weight: .semibold))
                                        Gap(h: 15)
                                        Text(v.element.name)
                                            .font(.system(size: 15))
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

                    Gap(h: size.height / 6)
                    Text("DRAG TO SELECT")
                        .font(.system(size: 15))
                        .kerning(5.0)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    Gap(h: size.height / 12)
                    
                    HStack{
                        Text("\(vm.budgetTypes[scrollToIndex].image.capitalized) selected")
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .padding(13)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                            }
                            .onTapGesture{
                                //router.push(to: .CityVisited)
                            }
                    }
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
                    .padding(.top, 20)
                    .background {
                        Rectangle()
                              .foregroundStyle(.white)
                              .shadow(color: .gray.opacity(0.1), radius: 3.5, y: -5)
                    }
                    .offset(y: size.height / 23)
                    .opacity(1)
                    .transition(.move(edge: .bottom))
                                            
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            }
            
        }
     
       
       
      
    }
}

#Preview {
    BudgetView()
        .environmentObject(PersonalInfoVM())
}
