//
//  TestView.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import SwiftUI

struct TestView: View {
    @State var isOn: Bool = false
    @State var vm = TestViewModel()
    let colors = [Color(hex: 0x9D62D9), Color(hex: 0x6262D9)]
    var body: some View {
        ZStack {
           
            
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .topTrailing, endPoint: .topLeading)
                .ignoresSafeArea()
                .blur(radius: 0)
            VStack{
                BaseViewContainer {
                    HStack {
                        Text("Helloe herer")
                            .testCard()
                        Text("Helloe herer")
                            .otherTest()
                    }
                }
                .padding()
                .background(.red)
                
                Toggle("Toggle", isOn: $isOn)
                    .toggleStyle(CustomToggle())
                
                Button {
                    vm.newAPICall()
                } label: {
                    Text("Tap Here")
                        .textLabel()
                }

            }
        }
        
    }
}

#Preview {
    TestView()
        .environmentObject(TestViewModel())
}


//.... Test Modifier
struct TestViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.vertical, .horizontal], 20)
            .background(.blue)
    }
}

//.... TextModifier

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.white)
            .padding()
    }
}

//.... other Modifier
struct OtherViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.vertical, .horizontal], 20)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 40))
     
    }
}

// Text extension
extension Text {
    func textLabel()-> some View{
        self.modifier(TextModifier())
    }
}

// View extension
extension View {
    func testCard() -> some View {
        self.modifier(TestViewModifier())
    }
    
    func otherTest()-> some View {
        self.modifier(OtherViewModifier())
    }
}

// style configs
struct CustomToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.label
            Text(configuration.isOn ? "On" : "Off")
                .padding()
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
    
}

    // ViewBuilder

struct BaseViewContainer<Content: View> : View {
    var content : Content
    init(@ViewBuilder content:()-> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .padding(.horizontal, 30)
    }
}

// HEX color extension
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}


