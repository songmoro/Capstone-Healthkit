//
//  StorageView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI

struct StorageView: View {
    @EnvironmentObject var UserData : UserDataClass // 유저 데이터
    @EnvironmentObject var UserStorage : UserStorageClass // 유저 보관함
    
    private let PetImage : String = "PetImage" // 불러올 펫
    var Petlist : [Int] = []
    
    var body: some View {
        ZStack() {
            Color(decimalRed: 27, green: 29, blue: 31)
                .ignoresSafeArea()
            
            VStack() { // 보관함 리스트 표시
                Text("\(UserStorage.StorageAmount) / \(UserStorage.StorageMaxAmount)")
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        
                        ForEach(UserStorage.StorageList, id : \.self) { row in
                            HStack(spacing: 30) {
                                ForEach(0..<2) { column in
                                    
                                    VStack() {
                                        ZStack() {
                                            
                                            RoundedRectangle(cornerRadius: 30)
                                                .foregroundColor(.gray)
                                                .frame(width: 150, height: 150)
                                            
                                            Button(action : {UserData.PetNumber = row + column}) { // 펫 선택 버튼
                                                
                                                Image("\(PetImage)\(row + column)")
                                                    .resizable()
                                                    .frame(width: 130, height: 130)
                                                    .shadow(radius: 2)
                                                    .blur(radius: CGFloat(UserStorage.StorageHaveList.contains(row + column) ? 0 : 10))
                                                
                                            }
                                            .disabled(UserStorage.StorageHaveList.contains(row + column) ? false : true)
                                                
                                        }
                                        Text("\(PetImage) \(row + column)")
                                            .foregroundColor(UserData.PetNumber == (row + column) ? .white : .gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView().environmentObject(UserDataClass()).environmentObject(UserStorageClass())
    }
}
