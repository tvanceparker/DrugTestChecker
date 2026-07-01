//
//  TodayView.swift
//  DrugTestChecker/Views
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import SwiftUI
import SwiftData
import DrugTestCheckerCore

struct TodayView: View {
    @State private var status: DrugTestStatus = .notChecked
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TestResult.checkedAt, order: .reverse)
    private var results: [TestResult]
    
    private var latestResult: TestResult? {
        results.first
    }

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
                        saveResult(status: .completedTest, rawPortalText: "User marked test completed")
                    }
                    .buttonStyle(.bordered)
                }

                Divider()

                VStack(spacing: 12) {
                    Text("Preview States")
                        .font(.headline)

                    HStack {
                        Button("Not Checked") {
                            saveResult(status: .notChecked, rawPortalText: "Preview: not checked")
                        }
                        Button("Clear"){
                            saveResult(status: .noTestToday, rawPortalText: "Preview: no test today")
                        }
                        Button("Test") {
                            saveResult(status: .needToTest, rawPortalText: "Preview: need to test")
                        }
                    }
                    .buttonStyle(.bordered)

                    HStack {
                        Button("Completed") {
                            saveResult(status: .completedTest, rawPortalText: "Preview: completed test")
                        }

                        Button("Error") {
                            saveResult(status: .error, rawPortalText: "Preview: error")
                        }

                        Button("Unknown") {
                            saveResult(status: .unknown, rawPortalText: "Preview: unknown")
                        }
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Today")
            .onAppear {
                if let latestResult {
                    status = latestResult.status
                }
            }
        }
    }
    private func saveResult(status: DrugTestStatus, rawPortalText: String = ""){
        let result = TestResult(
            checkedAt: .now,
            status: status,
            rawPortalText: rawPortalText
        )
        modelContext.insert(result)
        
        do {
            try modelContext.save()
            self.status = status
        } catch {
            print("Failed to save test result: \(error)")
        }
    }
}
