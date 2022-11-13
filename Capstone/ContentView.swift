//
//  ContentView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/16.
//

import SwiftUI

@MainActor class UserDataClass : ObservableObject { // 유저 데이터
    @Published var Xp = 0.0 // 경험치 게이지
    @Published var HaveXp = 0.0 // 소유 경험치
    @Published var Level = 0 // 현재 레벨
    @Published var LevelUp = false // 경험치 게이지 100 여부
    @Published var PetNumber = 1 // 선택된 펫
    
    @Published var KcalAmount = 0 // 총 칼로리
    @Published var ExerTimeAmount = 0 // 총 운동 시간
    @Published var StandTimeAmount = 0 // 총 일어서기 시간
    @Published var XpAmount = 0 // 총 경험치 사용량
}

@MainActor class UserAchivementClass : ObservableObject { // 유저 업적
    @Published var AchiveCount = 0 // 달성 업적 개수
    @Published var AchiveMaxCount = 20 // 달성 가능 최대 업적 개수
    
    @Published var AchiveNew = 0 // 달성한 새로운 업적 수
    
    @Published var AchiveList : [String] = [ // 업적 리스트
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
    
    @Published var AchiveAmount : [Int] = [ // 업적 계수
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
    
    @Published var AchiveObject : [String] = [ // 읽을 데이터
        "KcalAmount",
        "KcalAmount",
        "KcalAmount",
        "ExerTimeAmount",
        "ExerTimeAmount",
        "ExerTimeAmount",
        "StandTimeAmount",
        "StandTimeAmount",
        "StandTimeAmount",
        "StorageAmount",
        "StorageAmount", // 10
        "StorageAmount",
        "StorageAmount",
        "StorageAmount",
        "Level",
        "Level",
        "Level",
        "XpAmount",
        "XpAmount",
        "XpAmount"
    ]
    
    @Published var AchivePass : [Bool] = [ // 달성 여부
        false, false, false, false, false,
        false, false, false, false, false,
        false, false, false, false, false,
        false, false, false, false, false,
    ]
}

@MainActor class UserStorageClass : ObservableObject { // 유저 보관함
    @Published var StorageAmount = 1 // 펫 보유 수
    @Published var StorageMaxAmount = 5 // 펫 최대 보유 수
    @Published var StorageList : [Int] = [1, 3, 5] // 배열에 들어갈 리스트
    
    @Published var StorageHaveList : Set<Int> = [1] // 현재 보유 펫 번호
    @Published var StorageNotHaveList : Set<Int> = [2, 3, 4, 5] // 현재 미보유 펫 번호
}

@MainActor class UserActivityClass : ObservableObject { // 유저 활동
    @Published var Auth = 0 // 권한 인증 여부
    
    @Published var Kcal = 0.0 // 당일 칼로리
    @Published var ExerTime = 0.0 // 당일 운동 시간
    @Published var StandTime = 0.0 // 당일 일어서기 시간
    
    @Published var KcalMax = 400.0 // 당일 최대 칼로리
    @Published var ExerTimeMax = 60.0 // 당일 최대 운동 시간
    @Published var StandTimeMax = 10.0 // 당일 최대 일어서기 시간
}

struct ContentView: View { // 주축 뷰
    @State private var TabSelect = 1 // 현재 선택한 탭 번호
    
    @StateObject var UserData = UserDataClass() // 유저 데이터 연동
    @StateObject var UserStorage = UserStorageClass() // 유저 보관함 연동
    @StateObject var UserAchivement = UserAchivementClass() // 유저 업적 연동
    @StateObject var UserActivity = UserActivityClass() // 유저 활동 연동
    
    init() { // 탭 기본 세팅
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = UIColor(Color(decimalRed: 27, green: 29, blue: 31))
        UITabBar.appearance().barTintColor = UIColor(Color(decimalRed: 27, green: 29, blue: 31))
    }
    
    var body: some View {
        TabView(selection: $TabSelect) { // 탭
            AchievementView()
                .tabItem() {
                    Label("Achive", systemImage: "trophy")
                }
                .tag(0)
                //.badge(userachivement.AchiveNew) // 새로 달성한 업적 표시
            
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
        .environmentObject(UserData)
        .environmentObject(UserStorage)
        .environmentObject(UserAchivement)
        .environmentObject(UserActivity)
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray
        }
        .accentColor(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
