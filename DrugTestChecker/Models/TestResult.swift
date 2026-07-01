//
//  TestResult.swift
//  DrugTestChecker/Models
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import Foundation
import SwiftData
import DrugTestCheckerCore

@Model
final class TestResult {
    var checkedAt: Date
    var statusRawValue: String
    var rawPortalText: String
    var notes: String?

    init(
        checkedAt: Date = .now,
        status: DrugTestStatus,
        rawPortalText: String = "",
        notes: String? = nil
    ) {
        self.checkedAt = checkedAt
        self.statusRawValue = status.rawValue
        self.rawPortalText = rawPortalText
        self.notes = notes
    }

    var status: DrugTestStatus {
        DrugTestStatus(rawValue: statusRawValue) ?? .unknown
    }
}
