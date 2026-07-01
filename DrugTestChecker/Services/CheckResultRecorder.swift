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
        notes: String? = nil,
        url: String? = nil,
        pin: String? = nil,
        lastName: String? = nil,
        pageTitle: String? = nil,
        isSuccess: Bool? = true
    ) {
        let result = TestResult(
            checkedAt: checkedAt,
            status: status,
            rawPortalText: rawPortalText,
            notes: notes,
            url: url,
            pin: pin,
            lastName: lastName,
            pageTitle: pageTitle,
            isSuccess: isSuccess
        )

        modelContext.insert(result)

        do {
            try modelContext.save()
        } catch {
            print("Failed to save test result: \(error)")
        }
    }
}
