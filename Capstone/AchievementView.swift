//
//  AchievementView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI

struct AchievementView: View {
    @EnvironmentObject var userachivement : UserAchivement
    @EnvironmentObject var User : Userdata
    @EnvironmentObject var userstorage : UserStorage
    
    func ref(row:Int) -> Int {
        
        switch userachivement.AchiveObject[row] {
        case "Kcalamount" :
            return User.Kcalamount
            
        case "Exertimeamount" :
            return User.Exertimeamount
            
        case "Standtimeamount" :
            return User.Standtimeamount
            
        case "Storageamount" :
            return userstorage.Storageamount
            
        case "Level" :
            return User.Level
            
        case "xpamount" :
            return User.xpamount
            
        default:
            return 0
        }
    }
    
    var body: some View {
        
        ZStack() {
            Color(decimalRed: 27, green: 29, blue: 31)
                .ignoresSafeArea()
            
            VStack() {
                
                Text("\(userachivement.Achivecount) / \(userachivement.AchiveMaxcount)")
                    .foregroundColor(.white)
                    .font(.title)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(0..<20) { row in
                            
                            let Achiveamount = ref(row:row)
                            
                            
                            
                            HStack () {
                                ZStack() {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray)
                                        .frame(width: 300, height: 50)
                                    VStack() {
                                        Text("\(userachivement.AchiveList[row])")
                                        Text("\(Achiveamount) / \(userachivement.Achiveamount[row])")
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(.gray)
                                    .cornerRadius(10)
                                }
                                
                                
                                ZStack() {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray)
                                        .frame(width: 50, height: 50)
                                    
                                    if userachivement.AchivePass[row] {
                                        Text("Got")
                                            .foregroundColor(.yellow)
                                            .frame(width: 50, height: 50)
                                            .background(.gray)
                                            .cornerRadius(10)
                                    }
                                    else {
                                        if Achiveamount >= userachivement.Achiveamount[row] {
                                            Button(action: {
                                                userachivement.Achivecount += 1
                                                userachivement.AchiveNew -= 1
                                                userachivement.AchivePass[row] = true
                                                User.Havexp += 100
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
        AchievementView().environmentObject(UserAchivement())
            .environmentObject(Userdata())
            .environmentObject(UserStorage())
    }
}
