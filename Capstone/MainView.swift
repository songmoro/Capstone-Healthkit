//
//  MainView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI
import HealthKit

struct CouponView: View {
    @State var CouponText : String = "" // 쿠폰 입력란
    @Binding var ShowCoupon : Bool // 쿠폰 창 팝업 여부
    @State var EditText : Bool = false // 입력 중 여부
    
    @EnvironmentObject var UserData: UserDataClass // 유저 데이터
    @EnvironmentObject var UserActivity: UserActivityClass // 유저 활동
    @EnvironmentObject var UserStorage:UserStorageClass // 유저 보관함
    @EnvironmentObject var UserAchivement:UserAchivementClass // 유저 업적
    
    func Code(Coupon:String) { // 적용될 디버깅 코드
        switch Coupon {
        case "givexp10":
            UserData.HaveXp += 10
            
        case "givexp100":
            UserData.HaveXp += 100
            
        case "givexp1000":
            UserData.HaveXp += 1000
            
        case "clearxp":
            UserData.HaveXp = 0
            UserData.Level = 0
            UserData.Xp = 0
            UserData.LevelUp = false
            UserData.XpAmount = 0
            
        case "kcal100":
            UserActivity.Kcal += 100
            UserData.HaveXp += (100 / 400) * 100
            UserData.KcalAmount += 100
            
        case "kcal1000":
            UserActivity.Kcal += 1000
            UserData.HaveXp += (1000 / 400) * 100
            UserData.KcalAmount += 1000
            
        case "exer10":
            UserActivity.ExerTime += 10
            UserData.HaveXp += (10 / 60) * 100
            UserData.ExerTimeAmount += 10
            
        case "exer100":
            UserActivity.ExerTime += 100
            UserData.HaveXp += (100 / 60) * 100
            UserData.ExerTimeAmount += 100
            
        case "stand1":
            UserActivity.StandTime += 1
            UserData.HaveXp += (1 / 10) * 100
            UserData.StandTimeAmount += 1
            
        case "stand10":
            UserActivity.StandTime += 10
            UserData.HaveXp += (10 / 10) * 100
            UserData.StandTimeAmount += 10
            
        case "clearact":
            UserActivity.Kcal = 0
            UserActivity.ExerTime = 0
            UserActivity.StandTime = 0
            
            UserData.KcalAmount = 0
            UserData.ExerTimeAmount = 0
            UserData.StandTimeAmount = 0
            
        case "clearstorage":
            UserStorage.StorageAmount = 1
            UserStorage.StorageMaxAmount = 5
            UserStorage.StorageList = [1, 3, 5]
            
            UserStorage.StorageHaveList = [1]
            UserStorage.StorageNotHaveList = [2, 3, 4, 5]
            UserData.PetNumber = 1
            
        case "clearachive":
            UserAchivement.AchiveCount = 0
            UserAchivement.AchivePass = [
                false, false, false, false, false,
                false, false, false, false, false,
                false, false, false, false, false,
                false, false, false, false, false,
            ]
            
        case "clear":
            UserData.HaveXp = 0
            UserData.Level = 0
            UserData.Xp = 0
            UserData.LevelUp = false
            UserData.XpAmount = 0
            
            UserActivity.Kcal = 0
            UserActivity.ExerTime = 0
            UserActivity.StandTime = 0
            
            UserData.KcalAmount = 0
            UserData.ExerTimeAmount = 0
            UserData.StandTimeAmount = 0
            
            UserStorage.StorageAmount = 1
            UserStorage.StorageMaxAmount = 5
            UserStorage.StorageList = [1, 3, 5]
            
            UserStorage.StorageHaveList = [1]
            UserStorage.StorageNotHaveList = [2, 3, 4, 5]
            UserData.PetNumber = 1
            
            UserAchivement.AchiveCount = 0
            UserAchivement.AchivePass = [
                false, false, false, false, false,
                false, false, false, false, false,
                false, false, false, false, false,
                false, false, false, false, false,
            ]
            
        default: // 나머지
            break
        }
    }
    
    var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .frame(width: 312, height: 102)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                         .fill(Color(decimalRed: 27, green: 29, blue: 31))
                         .frame(width: 310, height: 100)
                )
                .overlay(
                        Button(action: {ShowCoupon = false}){
                            Image(systemName: "multiply.square.fill")
                                .font(.system(size: 25))
                                .padding(10)
                        }
                        ,alignment: .topTrailing
                )
                .overlay( // 쿠폰 창
                    HStack{
                        TextField("Type Coupon" , text : self.$CouponText)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .padding(15)
                            .padding(.horizontal,15)
                            .background(Color(.systemGray6))
                            .cornerRadius(15)
                            .overlay(
                                HStack{
                                    Spacer()
                                    
                                    if self.EditText{ // 입력 중일 때 입력 초기화 여부
                                        Button(action : {
                                            self.EditText = false
                                            self.CouponText = ""
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }){
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(Color(.white))
                                                .padding()
                                        }
                                    }else{
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(Color(.white))
                                            .padding()
                                    }
                                    
                                }
                            ).onTapGesture {
                                self.EditText = true
                            }
                        
                        Button(action: { // 등록 버튼
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil);
                            ShowCoupon = false;
                            Code(Coupon:CouponText)
                        }) {
                            
                            ZStack() {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 50, height: 50)
                                Text("Enroll")
                                    .foregroundColor(.white)
                                    .shadow(radius: 1)
                            }
                        }
                    }
                    .padding(10),alignment: .bottomLeading
                )
                .offset(x : -50, y : -50)
                .shadow(radius: 2)
            }
}

struct MainView: View {
    @State var ShowSideMenu = false // 사이드 메뉴 표시 여부
    @State var ShowCoupon = false // 쿠폰창 표시 여부
    
    var body: some View {
        let Drag = DragGesture() // 드래그
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.ShowSideMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in // 사이드 메뉴 표시에 따른 화면 상태
            ZStack(alignment: .trailing) {
                FullmainView(ShowMenu: self.$ShowSideMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.ShowSideMenu ? -geometry.size.width/2 : 0)
                
                if self.ShowSideMenu { // 사이드 메뉴 표시 여부
                    SidemenuView(ShowCoupon: self.$ShowCoupon)
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .trailing))
                }
                
                if self.ShowCoupon { // 쿠폰창 표시 여부
                    CouponView(ShowCoupon: self.$ShowCoupon)
                        
                }
                
            }
        }
        .gesture(Drag)
    }
}

func authorizeHealthkit() { // 권한 허용 함수
    let HealthStore = HKHealthStore()
    let AllTypes = Set([
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!,
        HKObjectType.categoryType(forIdentifier: .appleStandHour)!
    ])
    
    if HKHealthStore.isHealthDataAvailable() { // 헬스 데이터 사용 여부 확인 후 권한 받아오기
        HealthStore.requestAuthorization(toShare: nil, read: AllTypes) { (Success, error) in if(Success) {
        
            print("permission granted")
        }
            
        }
    }
}

struct ActivityRingView: View {
    @EnvironmentObject var UserActivity : UserActivityClass // 유저 활동
    
    func PreDataSetting() { // 시뮬레이터용 사전 데이터 세팅
        UserActivity.Kcal = 0
        UserActivity.ExerTime = 0
        UserActivity.StandTime = 0
    }
    
    func KcalData() { // 당일 칼로리 불러오기
        let HealthStore = HKHealthStore()
        let Now = Date()
        let StartDate = Calendar.current.startOfDay(for: Now)
        let Predicate = HKQuery.predicateForSamples(withStart: StartDate, end: Now, options: .strictStartDate)
        
        let Type = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        
            let Query = HKStatisticsQuery(quantityType: Type, quantitySamplePredicate: Predicate, options:.cumulativeSum){(query, Result, error) in
                let QueryResult = Result?.sumQuantity() as Any
                UserActivity.Kcal = (QueryResult as AnyObject).doubleValue(for: HKUnit.kilocalorie())
                print("\(UserActivity.Kcal) Kcal")
            }
            HealthStore.execute(Query)
    }
    
    func ExerTimeData() { // 당일 운동 시간 불러오기
        let HealthStore = HKHealthStore()
        let Now = Date()
        let StartDate = Calendar.current.startOfDay(for: Now)
        let Predicate = HKQuery.predicateForSamples(withStart: StartDate, end: Now, options: .strictStartDate)
        
        guard let appleExerciseTimeType = HKSampleType.quantityType(forIdentifier: .appleExerciseTime) else{
            return
        }
        
        let Query = HKStatisticsQuery(quantityType: appleExerciseTimeType, quantitySamplePredicate: Predicate, options:.cumulativeSum){(query, Result, error) in
            let QueryResult = Result?.sumQuantity() as Any
            UserActivity.ExerTime = (QueryResult as AnyObject).doubleValue(for: HKUnit.minute())
            print("\(UserActivity.ExerTime) Min")
        }
        HealthStore.execute(Query)
    }
    
    func StandTimeData() { // 당일 일어서기 시간 불러오기
        let HealthStore = HKHealthStore()
        let Now = Date()
        let StartDate = Calendar.current.startOfDay(for: Now)
        let Predicate = HKQuery.predicateForSamples(withStart: StartDate, end: Now, options: .strictStartDate)
        
        guard let appleStandTime = HKSampleType.categoryType(forIdentifier: .appleStandHour) else{
            return
        }
        
        let SortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let Query = HKSampleQuery(sampleType: appleStandTime, predicate: Predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [SortDescriptor]) { (query, Result, Error) -> Void in
            if Error != nil {
                return
            }
            
            for Item in Result! {
                if let TmpSample = Item as? HKCategorySample {
                    if TmpSample.value == 0 {
                        UserActivity.StandTime += 1
                    }
                }
            }
            
            print("\(UserActivity.StandTime) Stand")
        }
            HealthStore.execute(Query)
    }
    
    func DataLoad() { // 당일 데이터 불러오기
        KcalData()
        ExerTimeData()
        StandTimeData()
    }
    
    var body: some View {
        ZStack() { // 레드, 그린, 블루링 표시
            ActivityRedringView(Progress:.constant((UserActivity.Kcal >= UserActivity.KcalMax ? UserActivity.KcalMax : UserActivity.Kcal) / UserActivity.KcalMax))
                .fixedSize()
            
            ActivityGreenringView(Progress: .constant((UserActivity.ExerTime >= UserActivity.ExerTimeMax ? UserActivity.ExerTimeMax : UserActivity.ExerTime) / UserActivity.ExerTimeMax))
                .fixedSize()
            
            ActivityBlueringView(Progress: .constant((UserActivity.StandTime >= UserActivity.StandTimeMax ? UserActivity.StandTimeMax : UserActivity.StandTime) / UserActivity.StandTimeMax))
        }
        .onAppear(perform: PreDataSetting)
    }

}

struct FullmainView: View {
    @State private var FeedPointText : String = "Feed Points!" // 피드 버튼 텍스트
    @Binding var ShowMenu: Bool // 사이드 메뉴 표시 여부
    
    @EnvironmentObject var UserData: UserDataClass
    @EnvironmentObject var UserStorage: UserStorageClass
    
    var body: some View {
        ZStack() {
            Color(decimalRed: 27, green: 29, blue: 31)
                .ignoresSafeArea()
            
            VStack() { // Main 영역
                HStack() { // 화면 상단
                    Spacer()
                    Spacer()
                    Text("Level : \(UserData.Level)") // LEVEL
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                    Button(action: {
                        if self.ShowMenu {
                            withAnimation {
                                self.ShowMenu = false
                            }
                        }
                        else {
                            withAnimation {
                                self.ShowMenu = true
                            }
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 30))
                    }
                    .padding()
                }
                
                VStack() { // 게이지
                    Gauge(value: UserData.Xp, in: 0...100){
                        Text("You have \(Int(UserData.HaveXp)) points")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                    }
                currentValueLabel: {
                    if UserData.LevelUp == false {
                        Text("Need \(100 - Int(UserData.Xp)) points more!")
                    }
                    else{
                        Text("100 points are required to Level up")
                    }
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                    
                    
                    
                }
                .frame(width: 300)
                .foregroundColor(.white)
                .tint(.red)
                    
                    
                }
                Spacer()
                
                ZStack() { // 링 표시
                    ActivityRingView()
                        .onAppear(
                            perform: authorizeHealthkit
                        )
                    let PetImage : String = "PetImage" // 불러올 펫 이미지
                    
                    Image("\(PetImage)\(UserData.PetNumber)")
                        .resizable()
                        .frame(width : (UserData.Xp < 100 ? UserData.Xp + 100 : 250))
                        .frame(height : (UserData.Xp < 100 ? UserData.Xp + 100 : 250))
                    
                }
                Spacer()
                
                HStack(alignment: .center) { // 화면 하단
                    Button(action: { // 피드 버튼
                        if UserData.LevelUp == true {
                            if UserData.HaveXp >= 100 {
                                UserData.LevelUp = false
                                UserData.Level += 1
                                UserData.Xp = 0
                                UserData.HaveXp -= 100
                                FeedPointText = "Feed Points!"
                            
                                if UserStorage.StorageAmount != UserStorage.StorageMaxAmount {
                                    let RandomInt = UserStorage.StorageNotHaveList.randomElement()!
                                    
                                    UserStorage.StorageHaveList.insert(RandomInt)
                                    UserStorage.StorageNotHaveList.remove(RandomInt)
                                    UserStorage.StorageAmount += 1
                                }
                                
                                UserData.XpAmount += 100
                            }
                            else{
                                
                            }
                        }
                        else{
                            if UserData.HaveXp >= 10 {
                                if UserData.Xp == 90 {
                                    UserData.LevelUp = true
                                    UserData.Xp += 10
                                    UserData.HaveXp -= 10
                                    FeedPointText = "Press to Level up!"
                                    
                                    UserData.XpAmount += 10
                                }
                                else{
                                    UserData.Xp += 10
                                    UserData.HaveXp -= 10
                                    
                                    UserData.XpAmount += 10
                                }
                            }
                        }
                    }) {
                        Spacer()
                        
                        ZStack() {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 40)
                            
                            Text("\(FeedPointText)")
                                .font(.title)
                                .shadow(color: .black, radius: 2)
                                .foregroundColor(.white)
                            
                        }
                    }
                    .disabled((UserData.LevelUp ? true : false) && (UserData.HaveXp >= 100 ? false : true))
                    
                    Spacer()
                    
                    
                    /*
                    Button(action: { // 애플 워치 공유 버튼
                
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.yellow)
                            .font(.system(size : 30))
                    }
                     */
                    Spacer()
                }
                Spacer()
                // Main 영역 종료
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserDataClass())
            .environmentObject(UserStorageClass())
            .environmentObject(UserActivityClass())
    }
}
