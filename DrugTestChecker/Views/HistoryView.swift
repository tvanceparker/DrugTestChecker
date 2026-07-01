//
//  HistoryView.swift
//  DrugTestChecker/Views
//
//  Created by Taylor Vance Parker on 7/1/26.
//
import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No Results Yet",
                systemImage: "clock",
                description: Text("Completed checks will appear here.")
            )
            .navigationTitle("History")
        }
    }
}
