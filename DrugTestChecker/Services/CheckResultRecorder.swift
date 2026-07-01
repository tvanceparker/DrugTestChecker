//
//  CheckResultRecorder.swift
//  DrugTestChecker/Services
//

import Foundation
import SwiftData
import DrugTestCheckerCore

struct CheckResultRecorder {
    let modelContext: ModelContext

    func save(
        status: DrugTestStatus,
        rawPortalText: String = "",
        checkedAt: Date = .now,
        notes: String? = nil
    ) {
        let result = TestResult(
            checkedAt: checkedAt,
            status: status,
            rawPortalText: rawPortalText,
            notes: notes
        )

        modelContext.insert(result)

        do {
            try modelContext.save()
        } catch {
            print("Failed to save test result: \(error)")
        }
    }
}
