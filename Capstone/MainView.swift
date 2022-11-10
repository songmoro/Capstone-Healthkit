//
//  MainView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI
import HealthKit

/*
let healthStore = HKHealthStore()

func requestAuthorization(){
    let read = Set([
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
    ])
    let share = Set([
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
    ])
    
    healthStore.requestAuthorization(toShare: share, read: read) { success, error in
        if error != nil {
            print(error.debugDescription)
        }else{
            if success {
                print("권한이 허락되었습니다.")
                
                func getRedringValue() {
                    guard let activeEnergyBurnedType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else{
                        return
                    }
                    
                    let now = Date()
                    let startDate = Calendar.current.startOfDay(for: now)
                    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
                    
                    
                    var cal:Double = 0.0
                    let query = HKStatisticsQuery(quantityType: activeEnergyBurnedType, quantitySamplePredicate: predicate, options:.cumulativeSum){(query, result, error) in
                        let query_result = result?.sumQuantity() as Any
                        cal = (query_result as AnyObject).doubleValue(for: HKUnit.kilocalorie())
                        print(cal)
                    }
                    healthStore.execute(query)
                    
                }
            }else{
                print("권한이 아직 없어요.")
            }
        }
    }
}
*/

struct CouponView: View {
    //Binding은 외부에서 값을 바인딩시킬수있다.
    //택스트필드에 들어갈 값을 저장하기위한 변수
    @State var text : String = ""
    @Binding var showCoupon : Bool
    @State var editText : Bool = false
    
    @EnvironmentObject var User: Userdata
    @EnvironmentObject var Activity: UserActivity
    @EnvironmentObject var userstorage:UserStorage
    
    func Code(Coupon:String) {
        switch Coupon {
        case "givexp10":
            User.Havexp += 10
            
        case "givexp100":
            User.Havexp += 100
            
        case "givexp1000":
            User.Havexp += 1000
            
        case "clearxp":
            User.Havexp = 0
            User.Level = 0
            User.xp = 0
            User.Levelup = false
            User.xpamount = 0
            
        case "kcal100":
            Activity.Kcal += 100
            User.Havexp += (100 / 400) * 100
            User.Kcalamount += 100
            
        case "kcal1000":
            Activity.Kcal += 1000
            User.Havexp += (1000 / 400) * 100
            User.Kcalamount += 1000
            
        case "exer10":
            Activity.Exertime += 10
            User.Havexp += (10 / 60) * 100
            User.Exertimeamount += 10
            
        case "exer100":
            Activity.Exertime += 100
            User.Havexp += (100 / 60) * 100
            User.Exertimeamount += 100
            
        case "stand1":
            Activity.StandTime += 1
            User.Havexp += (1 / 10) * 100
            User.Standtimeamount += 1
            
        case "stand10":
            Activity.StandTime += 10
            User.Havexp += (10 / 10) * 100
            User.Standtimeamount += 10
            
        case "clearact":
            Activity.Kcal = 0
            Activity.Exertime = 0
            Activity.StandTime = 0  
            
            User.Kcalamount = 0
            User.Exertimeamount = 0
            User.Standtimeamount = 0
            
        case "clearstorage":
            userstorage.Storageamount = 1
            userstorage.StorageMaxamount = 5
            userstorage.StorageList = [1, 3, 5]
            
            userstorage.StorageHaveList = [1]
            userstorage.StorageNotHaveList = [2, 3, 4, 5]
            User.Petnumber = 1
            
        default:
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
                        Button(action: {showCoupon = false}){
                            Image(systemName: "multiply.square.fill")
                                .font(.system(size: 25))
                                .padding(10)
                        }
                        ,alignment: .topTrailing
                )
                .overlay(
                    HStack{
                        //검색창을 받을수있는 택스트필드
                        TextField("Type Coupon" , text : self.$text)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                        //hint와 태두리에 간격을 띄우기위해 15정도의 간격을주고
                            .padding(15)
                        //양옆은 추가로 15를 더줌
                            .padding(.horizontal,15)
                        //배경색상은 자유롭게선택
                            .background(Color(.systemGray6))
                        //검색창이 너무각지면 딱딱해보이기때문에 모서리를 둥글게
                        //숫자는 취향것
                            .cornerRadius(15)
                        //내가만든 검색창 상단에
                        //돋보기를 넣어주기위해
                        //오버레이를 선언
                            .overlay(
                                //HStack을 선언하여
                                //가로로 view를 쌓을수있도록 하나 만들고
                                HStack{
                                    //맨오른쪽으로 밀기위해 Spacer()로 밀어준다.
                                    Spacer()
                                    //xcode에서 지원해주는 이미지
                                    
                                    if self.editText{
                                        //x버튼이미지를 클릭하게되면 입력되어있던값들을 취소하고
                                        //키입력 이벤트를 종료해야한다.
                                        Button(action : {
                                            self.editText = false
                                            self.text = ""
                                            //키보드에서 입력을 끝내게하는 코드
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }){
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(Color(.white))
                                                .padding()
                                        }
                                    }else{
                                        //magnifyingglass 를 사용
                                        //색상은 자유롭게 변경가능
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(Color(.white))
                                            .padding()
                                    }
                                    
                                }
                            ).onTapGesture {
                                self.editText = true
                            }
                        
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil);
                            showCoupon = false;
                            Code(Coupon:text)
                            
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
    @State var showMenu = false
    @State var showCoupon = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in
            ZStack(alignment: .trailing) {
                FullmainView(showMenu: self.$showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? -geometry.size.width/2 : 0)
                
                if self.showMenu {
                    SidemenuView(showCoupon: self.$showCoupon)
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .trailing))
                }
                
                if self.showCoupon {
                    CouponView(showCoupon: self.$showCoupon)
                        
                }
                
            }
        }
        .gesture(drag)
    }
}
//


//

//

//
func authorizeHealthkit() {
    let healthStore = HKHealthStore()
    let allTypes = Set([
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!,
        HKObjectType.categoryType(forIdentifier: .appleStandHour)!
    ])
    
    if HKHealthStore.isHealthDataAvailable() {
        healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in if(success) {
            
            print("permission granted")
        }
            
        }
    }
}

struct ActivityRingView: View {
    @EnvironmentObject var useractivity : UserActivity
    
    
    func Kcaldata() {
        print("GetEnergy Start")
        let healthStore = HKHealthStore()
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let Type = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        
            let query = HKStatisticsQuery(quantityType: Type, quantitySamplePredicate: predicate, options:.cumulativeSum){(query, result, error) in
                let query_result = result?.sumQuantity() as Any
                useractivity.Kcal = (query_result as AnyObject).doubleValue(for: HKUnit.kilocalorie())
                print("\(useractivity.Kcal) Kcal")
            }
            healthStore.execute(query)
    }
    
    func Workdata() {
        let healthStore = HKHealthStore()
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        guard let appleExerciseTimeType = HKSampleType.quantityType(forIdentifier: .appleExerciseTime) else{
            return
        }
        
        let query = HKStatisticsQuery(quantityType: appleExerciseTimeType, quantitySamplePredicate: predicate, options:.cumulativeSum){(query, result, error) in
            let query_result = result?.sumQuantity() as Any
            useractivity.Exertime = (query_result as AnyObject).doubleValue(for: HKUnit.minute())
            print("\(useractivity.Exertime) min")
        }
        healthStore.execute(query)
    }
    
    func Standdata() {
        let healthStore = HKHealthStore()
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        guard let appleStandTime = HKSampleType.categoryType(forIdentifier: .appleStandHour) else{
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: appleStandTime, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
            if error != nil {
                return
            }
            
            for item in tmpResult! {
                if let sample = item as? HKCategorySample {
                    if sample.value == 0 {
                        useractivity.StandTime += 1
                    }
                }
            }
            
            print("\(useractivity.StandTime) Stand")
        }
            healthStore.execute(query)
    }
    
    func DATA() {
        Kcaldata()
        Workdata()
        Standdata()
    }
    
    var body: some View {
        ZStack() {
            ActivityRedringView(progress:.constant((useractivity.Kcal >= useractivity.KcalMax ? useractivity.KcalMax : useractivity.Kcal) / useractivity.KcalMax))
                .fixedSize()
            
            ActivityGreenringView(progress: .constant((useractivity.Exertime >= useractivity.ExertimeMax ? useractivity.ExertimeMax : useractivity.Exertime) / useractivity.ExertimeMax))
                .fixedSize()
            
            ActivityBlueringView(progress: .constant((useractivity.StandTime >= useractivity.StandTimeMax ? useractivity.StandTimeMax : useractivity.StandTime) / useractivity.StandTimeMax))
        }
        .onAppear(perform: DATA)
    }

}
//

struct FullmainView: View {
    @State private var progress: CGFloat = 1.0 // ring

    @State private var Feedpoint : String = "Feed Points!"
    @Binding var showMenu: Bool
    
    @EnvironmentObject var User: Userdata
    @EnvironmentObject var Storage: UserStorage
    
    var body: some View {
        ZStack() {
            // Background 영역
            Color(decimalRed: 27, green: 29, blue: 31)
                .ignoresSafeArea()
            // Background 영역 종료
            
            // Main 영역
            VStack() {
                HStack() {
                    Spacer()
                    Spacer()
                    Text("Level : \(User.Level)") // LEVEL
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                    Button(action: {
                        if self.showMenu {
                            withAnimation {
                                self.showMenu = false
                            }
                        }
                        else {
                            withAnimation {
                                self.showMenu = true
                            }
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 30))
                    }
                    .padding()
                }
                
                VStack() {
                    Gauge(value: User.xp, in: 0...100){
                        Text("You have \(Int(User.Havexp)) points")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                    }
                currentValueLabel: {
                    if User.Levelup == false {
                        Text("Need \(100 - Int(User.xp)) points more!")
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
                
                ZStack() {
                    ActivityRingView()
                        .onAppear(
                            perform: authorizeHealthkit
                        )
                    let PetImage : String = "PetImage"
                    
                    Image("\(PetImage)\(User.Petnumber)")
                        .resizable()
                        .frame(width : (User.xp < 100 ? User.xp + 100 : 250))
                        .frame(height : (User.xp < 100 ? User.xp + 100 : 250))
                    
                }
                Spacer()
                
                HStack(alignment: .center) {
                    Button(action: {
                        if User.Levelup == true {
                            if User.Havexp >= 100 {
                                User.Levelup = false
                                User.Level += 1
                                User.xp = 0
                                User.Havexp -= 100
                                Feedpoint = "Feed Points!"
                            
                                if Storage.Storageamount != Storage.StorageMaxamount {
                                    let RandomInt = Storage.StorageNotHaveList.randomElement()!
                                    
                                    Storage.StorageHaveList.insert(RandomInt)
                                    Storage.StorageNotHaveList.remove(RandomInt)
                                    Storage.Storageamount += 1
                                }
                                
                                User.xpamount += 100
                            }
                            else{
                                
                            }
                        }
                        else{
                            if User.Havexp >= 10 {
                                if User.xp == 90 {
                                    User.Levelup = true
                                    User.xp += 10
                                    User.Havexp -= 10
                                    Feedpoint = "Press to Level up!"
                                    
                                    User.xpamount += 10
                                }
                                else{
                                    User.xp += 10
                                    User.Havexp -= 10
                                    
                                    User.xpamount += 10
                                }
                            }
                        }
                    }) {
                        Spacer()
                        
                        ZStack() {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 40)
                            
                            Text("\(Feedpoint)")
                                .font(.title)
                                .shadow(color: .black, radius: 2)
                                .foregroundColor(.white)
                            
                        }
                    }
                    .disabled((User.Levelup ? true : false) && (User.Havexp >= 100 ? false : true))
                    
                    Spacer()
                    
                    Button(action: {
                
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.yellow)
                            .font(.system(size : 30))
                    }
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
            .environmentObject(Userdata())
            .environmentObject(UserStorage())
            .environmentObject(UserActivity())
    }
}
