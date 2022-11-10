//
//  SidemenuView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI



struct SidemenuView: View {
    @Binding var showCoupon: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button(action : {print("1")}) {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("User ID")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 100)
            HStack{
                Button(action : {print("2"); showCoupon = true }) {
                    Image(systemName: "gift")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Coupon")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            HStack{
                Button(action : {print("3")}) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Infomation")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            HStack{
                Button(action : {print("4")}) {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Contact Us")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment:.trailing)
        .padding(.trailing, 50)
        .background(Color(red:32/255, green:32/255, blue:32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SidemenuView_Previews: PreviewProvider {
    static var previews: some View {
        SidemenuView(showCoupon: .constant(false))
    }
}
