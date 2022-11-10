//
//  SideopenView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI

/*
struct SideopenView: View {
    @State var showMenu = false
    
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                SideView(showMenu: self.$showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                if self.showMenu {
                    SidemenuView()
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
        }
        .gesture(drag)
    }
}
 */

struct SideView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showMenu = true
            }
        }) {
            Text("Show Menu")
        }
    }
}

struct SideopenView_Previews: PreviewProvider {
    static var previews: some View {
        SideopenView()
    }
}
