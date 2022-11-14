//
//  ContentView.swift
//  Capstone Watch App
//
//  Created by 송재훈 on 2022/09/16.
//

import SwiftUI

struct ContentView: View {
    
    @State var dataset: DataSet
    
    var body: some View {
        VStack {
            Image("\(dataset.PetImage)\(dataset.PetNumber)")
            Text("\(dataset.PetNumber)").padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataset: DataSet(id: 0, PetNumber: "1", PetImage: "PetImage"))
    }
}

