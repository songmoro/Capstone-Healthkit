//
//  AchievementView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI

struct AchievementView: View {
    @EnvironmentObject var UserAchivement : UserAchivementClass
    @EnvironmentObject var UserData : UserDataClass
    @EnvironmentObject var UserStorage : UserStorageClass
    
    func ref(row:Int) -> Int { // 참조 계수 결정
        
        switch UserAchivement.AchiveObject[row] {
        case "KcalAmount" :
            return UserData.KcalAmount
            
        case "ExerTimeAmount" :
            return UserData.ExerTimeAmount
            
        case "StandTimeAmount" :
            return UserData.StandTimeAmount
            
        case "StorageAmount" :
            return UserStorage.StorageAmount
            
        case "Level" :
            return UserData.Level
            
        case "XpAmount" :
            return UserData.XpAmount
            
        default:
            return 0
        }
    }
    
    var body: some View {
        
        ZStack() {
            Color(decimalRed: 27, green: 29, blue: 31)
                .ignoresSafeArea()
            
            VStack() { // 업적 리스트
                Text("\(UserAchivement.AchiveCount) / \(UserAchivement.AchiveMaxCount)")
                    .foregroundColor(.white)
                    .font(.title)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(0..<20) { row in
    
                            let AchiveAmount = ref(row:row) // 참조 계수 불러오기
                            
                            HStack () { // 업적 내용 및 달성도 표시
                                ZStack() {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray)
                                        .frame(width: 300, height: 50)
                                    VStack() {
                                        Text("\(UserAchivement.AchiveList[row])")
                                        Text("\(AchiveAmount) / \(UserAchivement.AchiveAmount[row])")
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(.gray)
                                    .cornerRadius(10)
                                }
                                
                                
                                ZStack() { // 달성 여부 표현
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray)
                                        .frame(width: 50, height: 50)
                                    
                                    if UserAchivement.AchivePass[row] {
                                        Text("Got")
                                            .foregroundColor(.yellow)
                                            .frame(width: 50, height: 50)
                                            .background(.gray)
                                            .cornerRadius(10)
                                    }
                                    else {
                                        if AchiveAmount >= UserAchivement.AchiveAmount[row] {
                                            Button(action: {
                                                UserAchivement.AchiveCount += 1
                                                UserAchivement.AchiveNew -= 1
                                                UserAchivement.AchivePass[row] = true
                                                UserData.HaveXp += 100
                                            }){
                                                Text("Get")
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(.yellow)
                                                    .shadow(radius: 4)
                                                    .cornerRadius(10)
                                            }
                                        }
                                        else {
                                            Text("Ing")
                                                .foregroundColor(.white)
                                                .frame(width: 50, height: 50)
                                                .background(.gray)
                                                .cornerRadius(10)
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
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView().environmentObject(UserAchivementClass())
            .environmentObject(UserDataClass())
            .environmentObject(UserStorageClass())
    }
}
