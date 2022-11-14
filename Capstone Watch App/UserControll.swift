//
//  UserControll.swift
//  Capstone Watch App
//
//  Created by 송재훈 on 2022/11/14.
//

import Foundation

final class UserData {
    var Datalist: [DataSet] = []

    private init() {
        self.Datalist.append(DataSet(id: 0, PetNumber: "1", PetImage: "PetImage"))
        self.Datalist.append(DataSet(id: 1, PetNumber: "2", PetImage: "PetImage"))
        self.Datalist.append(DataSet(id: 2, PetNumber: "3", PetImage: "PetImage"))
        self.Datalist.append(DataSet(id: 3, PetNumber: "4", PetImage: "PetImage"))
        self.Datalist.append(DataSet(id: 4, PetNumber: "5", PetImage: "PetImage"))
    }

    static let shared = UserData()
}

struct DataSet: Identifiable {
    var id: Int
    var PetNumber: String
    var PetImage: String
}
