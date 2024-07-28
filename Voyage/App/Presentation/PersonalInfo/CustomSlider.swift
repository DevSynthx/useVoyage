//
//  CustomSlider.swift
//  project-z
//
//  Created by Inyene Etoedia on 27/06/2024.
//

import SwiftUI

struct CustomSliderX: View {
    @State var value: Double = 30
    @Binding var sliderValue: Double
    var width: CGFloat = 258
    //@State var sliderValue: Double = 0
    let background = Color(red: 0.07, green: 0.07, blue: 0.12)
    var body: some View {
        VStack {
            ZStack{
                CustomSlider(
                               value: $sliderValue,
                               range: (0, 100),
                               step: 50,
                               knobWidth: 30
                           ) { components in
                               ZStack(alignment: .leading) {
                                   // Customize the appearance of the slider
    //                               Rectangle()
    //                                   .fill(Color.clear)
    //                                   //.fill(Color.gray.opacity(0.3))
    //                                   .frame(height: 6)
    //                                   .frame(width: 200)
    //                                   .modifier(components.barLeft)
                                   Rectangle()
                                       .fill(Color.gray.opacity(0.3))
                                       .frame(height: 6)
                                       .frame(width: width)
                                       .padding(.leading, 24)
                                   Rectangle()
                                       .fill(Color.green)
                                       .frame(height: 6)
                                       .frame(width: sliderValue * 2.9)
                                       .padding(.leading, 24)
                                  
                                       
    //                               Rectangle()
    //                              
    //                                   .fill(Color.gray.opacity(0.3))
    //                                   .frame(height: 6)
    //                                   .frame(width: 240)
    //                                   .modifier(components.barRight)
                                   
                                   Image("drag_arrows")
                                       .resizable()
                                       .scaledToFit()
                                       .background{
                                           Circle()
                                              // .fill(Color.white)
                                               .fill(.shadow(.inner(radius: 4, y: 1)))
                                               .stroke(Color.black, lineWidth: 5)
                                               .foregroundStyle(.white)
                                               .frame(width: components.knob.size.width, height: components.knob.size.height)
                                              
                                       }
                                       .modifier(components.knob)
                                   
                                       
                                      
                               }
                               
                           }
                           .frame(height: 30)
                          // .padding()
            }
        }
    
    }
}

#Preview {
    CustomSliderX( sliderValue: .constant(0))
}



struct CustomSlider<Component: View>: View {
    @Binding var value: Double
    var range: (Double, Double)
    var step: Double
    var knobWidth: CGFloat?
    let viewBuilder: (CustomSliderComponents) -> Component

    init(value: Binding<Double>, range: (Double, Double), step: Double, knobWidth: CGFloat? = nil,
         _ viewBuilder: @escaping (CustomSliderComponents) -> Component) {
        _value = value
        self.range = range
        self.step = step
        self.viewBuilder = viewBuilder
        self.knobWidth = knobWidth
    }

    var body: some View {
        GeometryReader { screenGeometry in
            self.view(screenGeometry: screenGeometry)
                .frame(width: screenGeometry.size.width * 0.9)
                .frame(maxWidth: .infinity)
        }
    }

    private func view(screenGeometry: GeometryProxy) -> some View {
        GeometryReader { geometry in
            self.view(geometry: geometry)
        }
    }

    private func view(geometry: GeometryProxy) -> some View {
        let frame = geometry.frame(in: .local)
        let drag = DragGesture(minimumDistance: 0).onChanged { drag in
            self.onDragChange(drag, frame)
        }
        let offsetX = self.getOffsetX(frame: frame)
        let knobSize = CGSize(width: knobWidth ?? frame.height, height: frame.height)
        let barLeftSize = CGSize(width: CGFloat(offsetX + knobSize.width * 0.5), height: frame.height)
        let barRightSize = CGSize(width: frame.width - barLeftSize.width, height: frame.height)

        let modifiers = CustomSliderComponents(
            barLeft: CustomSliderModifier(name: .barLeft, size: barLeftSize, offset: 0),
            barRight: CustomSliderModifier(name: .barRight, size: barRightSize, offset: barLeftSize.width),
            knob: CustomSliderModifier(name: .knob, size: knobSize, offset: offsetX)
        )

        let mainSteps = 3
               let totalSteps = mainSteps + (mainSteps - 1) * 9
               let stepWidth = frame.width / CGFloat(totalSteps - 1)
               let smallLineSpacing: CGFloat = stepWidth / 1.3
               
               return VStack {
                   Gap(h: 15)
                   ZStack {
                       viewBuilder(modifiers)
                           .gesture(drag)
                   }
                   .frame(height: frame.height)
                   Gap(h: 15)
                   HStack(alignment: .top, spacing: smallLineSpacing) {
                       ForEach(0..<totalSteps) { index in
                           if index % 10 == 0 {
                               Rectangle()
                                   .fill(getColor(for: index / 10))
                                   .frame(width: 2, height: 50)
                           } else if index < totalSteps - 1 {
                               Rectangle()
                                   .fill(Color.gray)
                                   .frame(width: 1, height: 30)
                           }
                       }
                   }
               }
               .frame(maxWidth: .infinity)
               .frame(height: frame.height)
    }
    
    func getColor(for step: Int) -> Color {
        switch step % 3 {
            case 0:
                return .tightColor
            case 1:
                return .midColor
            case 2:
                return .luxuryColor
            default:
                return Color.black
        }
    }

    private func onDragChange(_ drag: DragGesture.Value, _ frame: CGRect) {
        let width = (knob: Double(knobWidth ?? frame.size.height), view: Double(frame.size.width))
        let xrange = (min: Double(width.knob * 0.45), max: Double(width.view - width.knob * 1.45))
        var value = Double(drag.startLocation.x + drag.translation.width)
        value -= 0.5 * width.knob
        value = value > xrange.max ? xrange.max : value
        value = value < xrange.min ? xrange.min : value
        value = value.convert(fromRange: (xrange.min, xrange.max), toRange: range)
        value = (value / step).rounded() * step
        self.value = value
    }

    private func getOffsetX(frame: CGRect) -> CGFloat {
        let width = (knob: knobWidth ?? frame.size.height, view: frame.size.width)
        let xrange: (Double, Double) = (Double(width.knob * 0.45), Double(width.view - width.knob * 1.45))
        let result = self.value.convert(fromRange: range, toRange: xrange)
        return CGFloat(result)
    }
}

struct CustomSliderComponents {
    let barLeft: CustomSliderModifier
    let barRight: CustomSliderModifier
    let knob: CustomSliderModifier
}

struct CustomSliderModifier: ViewModifier {
    enum Name {
        case barLeft
        case barRight
        case knob
    }
    let name: Name
    let size: CGSize
    let offset: CGFloat

    func body(content: Content) -> some View {
        switch name {
        case .knob:
            return content
                .frame(width: size.width, height: size.height)
                .position(x: size.width / 2, y: size.height / 2)
                .offset(x: offset)
                .eraseToAnyView()
        default:
            return content
                .frame(width: size.width, height: size.height)
                .position(x: size.width / 2, y: size.height / 2)
                .offset(x: offset)
                .eraseToAnyView()
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

extension Double {
    func convert(fromRange: (Double, Double), toRange: (Double, Double)) -> Double {
        var value = self
        value -= fromRange.0
        value /= Double(fromRange.1 - fromRange.0)
        value *= toRange.1 - toRange.0
        value += toRange.0
        return value
    }
}


