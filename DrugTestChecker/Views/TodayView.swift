//
//  TodayView.swift
//  DrugTestChecker/Views
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import SwiftUI
import DrugTestCheckerCore

struct TodayView: View {
    @State private var status: DrugTestStatus = .notChecked

    private var statusSymbol: String {
        switch status {
        case .notChecked:
            return "questionmark.circle.fill"
        case .noTestToday:
            return "checkmark.circle.fill"
        case .needToTest:
            return "exclamationmark.circle.fill"
        case .completedTest:
            return "checkmark.seal.fill"
        case .error:
            return "exclamationmark.triangle.fill"
        case .unknown:
            return "questionmark.diamond.fill"
        }
    }

    private var statusMessage: String {
        switch status {
        case .notChecked:
            return "No check has been run today."
        case .noTestToday:
            return "You are not scheduled to test today."
        case .needToTest:
            return "You are required to test today."
        case .completedTest:
            return "You marked today's test as completed."
        case .error:
            return "The check failed. Try again or verify manually."
        case .unknown:
            return "The portal returned a result the app did not recognize."
        }
    }

    private var statusColor: Color {
        switch status.colorToken {
        case .green:
            return .green
        case .red:
            return .red
        case .amber:
            return .orange
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Image(systemName: statusSymbol)
                        .font(.system(size: 72))
                        .foregroundStyle(statusColor)

                    Text(status.displayTitle)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(statusMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                Button("Check Now") {
                    status = .noTestToday
                }
                .buttonStyle(.borderedProminent)

                if status == .needToTest {
                    Button("I Tested") {
                        status = .completedTest
                    }
                    .buttonStyle(.bordered)
                }

                Divider()

                VStack(spacing: 12) {
                    Text("Preview States")
                        .font(.headline)

                    HStack {
                        Button("Not Checked") { status = .notChecked }
                        Button("Clear") { status = .noTestToday }
                        Button("Test") { status = .needToTest }
                    }
                    .buttonStyle(.bordered)

                    HStack {
                        Button("Completed") { status = .completedTest }
                        Button("Error") { status = .error }
                        Button("Unknown") { status = .unknown }
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Today")
        }
    }
}
