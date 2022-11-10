//
//  StorageView.swift
//  Capstone
//
//  Created by 송재훈 on 2022/09/21.
//

import SwiftUI

struct StorageView: View {
    @EnvironmentObject var User : Userdata
    @EnvironmentObject var Storage : UserStorage
    
    private let PetImage : String = "PetImage"
    var Petlist : [Int] = []
    
    
    
    var body: some View {
        ZStack() {
            Color(decimalRed: 27, green: 29, blue: 31)
                .ignoresSafeArea()
            
            VStack() {
                Text("\(Storage.Storageamount) / \(Storage.StorageMaxamount)")
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        
                        //ForEach(Storage.StorageList, id: \.self)
                        ForEach(Storage.StorageList, id : \.self) { row in
                            HStack(spacing: 30) {
                                ForEach(0..<2) { column in
                                    
                                    
                                    
                                    VStack() {
                                        ZStack() {
                                            /*
                                            Text("Image \(row),\(column)")
                                                .foregroundColor(.white)
                                                .frame(width: 150, height: 150)
                                                .background(.gray)
                                                .cornerRadius(30)
                                            */
                                            
                                            RoundedRectangle(cornerRadius: 30)
                                                .foregroundColor(.gray)
                                                .frame(width: 150, height: 150)
                                            
                                            
                                            
                                            Button(action : {User.Petnumber = row + column}) {
                                                
                                                
                                                Image("\(PetImage)\(row + column)")
                                                    .resizable()
                                                    .frame(width: 130, height: 130)
                                                    .shadow(radius: 2)
                                                    .blur(radius: CGFloat(Storage.StorageHaveList.contains(row + column) ? 0 : 10))
                                                
                                            }
                                            .disabled(Storage.StorageHaveList.contains(row + column) ? false : true)
                                                
                                        }
                                        
                                        
                                        Text("\(PetImage) \(row + column)")
                                            .foregroundColor(User.Petnumber == (row + column) ? .white : .gray)
                                         


                                    }
                                }
                            }
                        }
                    }
                }
                /*
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        ForEach(0..<20) { row in
                            HStack(spacing: 30) {
                                ForEach(0..<2) { column in
                                    VStack() {
                                        Text("Image \(row),\(column)")
                                            .foregroundColor(.white)
                                            .frame(width: 150, height: 150)
                                            .background(.gray)
                                            .cornerRadius(30)
                                        Text("Name")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                }
                */
            }
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView().environmentObject(Userdata()).environmentObject(UserStorage())
    }
}
