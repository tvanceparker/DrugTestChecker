//
//  ContentView.swift
//  DrugTestChecker
//
//  Created by Taylor Vance Parker on 6/25/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "checkmark.circle")
                }
                .tag(0)

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .tag(1)

            ProfileView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
