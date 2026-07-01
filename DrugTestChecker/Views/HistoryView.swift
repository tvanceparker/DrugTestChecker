//
//  HistoryView.swift
//  DrugTestChecker/Views
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import SwiftUI
import SwiftData
import DrugTestCheckerCore

struct HistoryView: View {
    @Query(sort: \TestResult.checkedAt, order: .reverse)
    private var results: [TestResult]

    var body: some View {
        NavigationStack {
            Group {
                if results.isEmpty {
                    ContentUnavailableView(
                        "No Results Yet",
                        systemImage: "clock",
                        description: Text("Completed checks will appear here.")
                    )
                } else {
                    List(results) { result in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(result.status.displayTitle)
                                .font(.headline)

                            Text(result.checkedAt, style: .date)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Text(result.checkedAt, style: .time)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            if !result.rawPortalText.isEmpty {
                                Text(result.rawPortalText)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}
