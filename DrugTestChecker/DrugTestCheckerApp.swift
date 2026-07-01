//
//  DrugTestCheckerApp.swift
//  DrugTestChecker
//
//  Created by Taylor Vance Parker on 6/25/26.
//

import SwiftUI
import SwiftData
import DrugTestCheckerCore

@main
struct DrugTestCheckerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Profile.self,
            TestResult.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
