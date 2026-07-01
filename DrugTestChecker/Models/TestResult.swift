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

    var url: String?
    var pin: String?
    var lastName: String?
    var pageTitle: String?
    var isSuccess: Bool?

    init(
        checkedAt: Date = .now,
        status: DrugTestStatus,
        rawPortalText: String = "",
        notes: String? = nil,
        url: String? = nil,
        pin: String? = nil,
        lastName: String? = nil,
        pageTitle: String? = nil,
        isSuccess: Bool? = true
    ) {
        self.checkedAt = checkedAt
        self.statusRawValue = status.rawValue
        self.rawPortalText = rawPortalText
        self.notes = notes
        self.url = url
        self.pin = pin
        self.lastName = lastName
        self.pageTitle = pageTitle
        self.isSuccess = isSuccess
    }

    var status: DrugTestStatus {
        DrugTestStatus(rawValue: statusRawValue) ?? .unknown
    }
}
