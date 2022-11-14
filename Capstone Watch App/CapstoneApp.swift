//
//  CapstoneApp.swift
//  Capstone Watch App
//
//  Created by 송재훈 on 2022/09/16.
//

import SwiftUI
import WatchKit
import ClockKit

@main
struct MultiCompApp: App {
    @Environment(\.scenePhase) var scenePhase

    @State private var selectedTab = 0

    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView(selection: $selectedTab) {
                    ForEach(UserData.shared.Datalist, id: \.id) { data in
                        ContentView(dataset: data).tag(data.id)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .onContinueUserActivity("org.codechimp.multicomp", perform: {userActivity in
                if let id = userActivity.userInfo?["id"] as? Int {
                    selectedTab = id
                }
            })
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                let server = CLKComplicationServer.sharedInstance()
                
                for complication in server.activeComplications ?? [] {
                    server.reloadTimeline(for: complication)
                }

                server.reloadComplicationDescriptors()
            default: break
            }
        }
    }
}
