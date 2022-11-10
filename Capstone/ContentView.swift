//
//  ContentView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/16.
//

import SwiftUI

@MainActor class Userdata : ObservableObject {
    //@ObervedObjet를 사용하기위해 @Published를 할당
    @Published var xp = 0.0
    @Published var Havexp = 0.0
    @Published var Level = 0
    @Published var Levelup = false
    @Published var Petnumber = 1
    
    @Published var Kcalamount = 0
    @Published var Exertimeamount = 0
    @Published var Standtimeamount = 0
    @Published var xpamount = 0
}

@MainActor class UserAchivement : ObservableObject {
    @Published var Achivecount = 0
    @Published var AchiveMaxcount = 20
    
    @Published var AchiveNew = 0
    
    @Published var AchiveList : [String] = [
        "활동 칼로리 총 100Kcal 달성",
        "활동 칼로리 총 1000Kcal 달성",
        "활동 칼로리 총 10000Kcal 달성",
        "운동 시간 총 10분 달성",
        "운동 시간 총 100분 달성",
        "운동 시간 총 1000분 달성",
        "일어서기 총 1회 달성",
        "일어서기 총 10회 달성",
        "일어서기 총 100회 달성",
        "펫 총 1마리 수집",
        "펫 총 2마리 수집",
        "펫 총 3마리 수집",
        "펫 총 4마리 수집",
        "펫 총 5마리 수집",
        "레벨 1 달성",
        "레벨 10 달성",
        "레벨 100 달성",
        "소모 포인트 총 100pts 달성",
        "소모 포인트 총 1000pts 달성",
        "소모 포인트 총 10000pts 달성"
    ]
    
    @Published var Achiveamount : [Int] = [
        100,
        1000,
        10000,
        10,
        100,
        1000,
        1,
        10,
        100,
        1,
        2, // 10
        3,
        4,
        5,
        1,
        10,
        100,
        100,
        1000,
        10000
    ]
    
    @Published var AchiveObject : [String] = [
        "Kcalamount",
        "Kcalamount",
        "Kcalamount",
        "Exertimeamount",
        "Exertimeamount",
        "Exertimeamount",
        "Standtimeamount",
        "Standtimeamount",
        "Standtimeamount",
        "Storageamount",
        "Storageamount", // 10
        "Storageamount",
        "Storageamount",
        "Storageamount",
        "Level",
        "Level",
        "Level",
        "xpamount",
        "xpamount",
        "xpamount"
    ]
    
    @Published var AchivePass : [Bool] = [
        false, false, false, false, false,
        false, false, false, false, false,
        false, false, false, false, false,
        false, false, false, false, false,
    ]
}

@MainActor class UserStorage : ObservableObject {
    @Published var Storageamount = 1
    @Published var StorageMaxamount = 5
    @Published var StorageList : [Int] = [1, 3, 5]
    
    @Published var StorageHaveList : Set<Int> = [1]
    @Published var StorageNotHaveList : Set<Int> = [2, 3, 4, 5]
}

@MainActor class UserActivity : ObservableObject {
    @Published var Auth = 0
    
    @Published var Kcal = 0.0
    @Published var Exertime = 0.0
    @Published var StandTime = 0.0
    
    @Published var KcalMax = 400.0
    @Published var ExertimeMax = 60.0
    @Published var StandTimeMax = 10.0
}

struct ContentView: View {
    @State private var selection = 1
    
    @StateObject var userdata = Userdata()
    @StateObject var userstorage = UserStorage()
    @StateObject var userachivement = UserAchivement()
    @StateObject var useractivity = UserActivity()
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = UIColor(Color(decimalRed: 27, green: 29, blue: 31))
        UITabBar.appearance().barTintColor = UIColor(Color(decimalRed: 27, green: 29, blue: 31))
    }
    
    var body: some View {
        TabView(selection: $selection) {
            AchievementView()
                .tabItem() {
                    Label("Achive", systemImage: "trophy")
                }
                .tag(0)
                //.badge(userachivement.AchiveNew)
            
            MainView()
                .tabItem() {
                    Label("Main", systemImage: "house")
                }
                .tag(1)
            
            StorageView()
                .tabItem() {
                    Label("Storage", systemImage: "archivebox")
                }
                .tag(2)
            
        }
        .environmentObject(userdata)
        .environmentObject(userstorage)
        .environmentObject(userachivement)
        .environmentObject(useractivity)
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray
            //UITabBar.appearance().scrollEdgeAppearance
        }
        .accentColor(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
