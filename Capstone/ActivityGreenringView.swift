//
//  ActivityRingView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/20.
//

import SwiftUI

extension Color { // 색 사전 정의
    public static var outlineGreen: Color {
        return Color(decimalRed: 37, green: 55, blue: 29)
    }
    
    public static var darkGreen: Color {
        return Color(decimalRed: 120, green: 221, blue: 67)
    }
    
    public static var lightGreen: Color {
        return Color(decimalRed: 224, green: 254, blue: 83)
    }
    
    public init(decimalGreen red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
}

struct ActivityGreenringView: View {
    @Binding var Progress: CGFloat // 진행도
    
    var colors: [Color] = [Color.darkGreen, Color.lightGreen] // 색 배열
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.outlineGreen, lineWidth: 20)
            Circle()
                .trim(from: 0, to: Progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
            ).rotationEffect(.degrees(-90))
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.darkGreen)
                .offset(y: -140)
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Progress > 0.95 ? Color.lightGreen: Color.lightGreen.opacity(0))
                .offset(y: -140)
                .rotationEffect(Angle.degrees(360 * Double(Progress)))
                .shadow(color: Progress > 0.96 ? Color.black.opacity(0.1): Color.clear, radius: 3, x: 4, y: 0)
        }.frame(width: 280, height: 280, alignment: .center)
    }
}

struct ActivityGreenringView_Previews: PreviewProvider {
    
    static var previews: some View {
        ActivityGreenringView(Progress: .constant(0))
    }
}
