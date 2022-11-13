//
//  ActivityRingView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/20.
//

import SwiftUI

extension Color { // 색 사전 정의
    public static var outlineBlue: Color {
        return Color(decimalRed: 30, green: 51, blue: 38)
    }
    
    public static var darkBlue: Color {
        return Color(decimalRed: 89, green: 124, blue: 220)
    }
    
    public static var lightBlue: Color {
        return Color(decimalRed: 117, green: 251, blue: 177)
    }
    
    public init(decimalBlue red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
}



struct ActivityBlueringView: View {
    @Binding var Progress: CGFloat // 진행도
    
    var colors: [Color] = [Color.darkBlue, Color.lightBlue] // 색 배열
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.outlineBlue, lineWidth: 20)
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
                .foregroundColor(Color.darkBlue)
                .offset(y: -120)
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Progress > 0.95 ? Color.lightBlue: Color.lightBlue.opacity(0))
                .offset(y: -120)
                .rotationEffect(Angle.degrees(360 * Double(Progress)))
                .shadow(color: Progress > 0.96 ? Color.black.opacity(0.1): Color.clear, radius: 3, x: 4, y: 0)
        }.frame(width: 240, height: 240, alignment: .center)
    }
}

struct ActivityBlueringView_Previews: PreviewProvider {
    
    static var previews: some View {
        ActivityBlueringView(Progress: .constant(0))
    }
}
