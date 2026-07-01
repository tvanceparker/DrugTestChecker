//
//  DrugTestStatus.swift
//  DrugTestCheckerCore
//
//  Created by Taylor Vance Parker on 6/25/26.
//

public enum DrugTestStatus: String, Codable, CaseIterable, Sendable {
    case notChecked
    case noTestToday
    case needToTest
    case completedTest
    case error
    case unknown
}

public enum StatusColorToken: String, Sendable {
    case green
    case red
    case amber
}

public extension DrugTestStatus {
    var displayTitle: String {
        switch self {
        case .notChecked:
            return "Not Checked"
        case .noTestToday:
            return "No Test Today"
        case .needToTest:
            return "Need to Test"
        case .completedTest:
            return "Test Completed"
        case .error:
            return "Check Error"
        case .unknown:
            return "Unknown Result"
        }
    }

    var colorToken: StatusColorToken {
        switch self {
        case .noTestToday, .completedTest:
            return .green
        case .needToTest:
            return .red
        case .notChecked, .error, .unknown:
            return .amber
        }
    }
}
