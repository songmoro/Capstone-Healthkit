//
//  SidemenuView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI

struct SidemenuView: View { // 사이드 메뉴
    @Binding var ShowCoupon: Bool // 쿠폰창 표시 여부
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{ // 유저 고유 번호
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
            HStack{ // 쿠폰창
                Button(action : {print("2"); ShowCoupon = true }) {
                    Image(systemName: "gift")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Coupon")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            HStack{ // 가이드 표시 버튼
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
            HStack{ // 개발자 연락처
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
        SidemenuView(ShowCoupon: .constant(false))
    }
}
