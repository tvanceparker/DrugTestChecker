//
//  PortalResultParser.swift
//  DrugTestCheckerCore
//
//  Created by Taylor Vance Parker on 6/25/26.
//


// PortalResultParser.swift
public enum PortalResultParser {
    public static func parseStatus(from portalText: String) -> DrugTestStatus {
        let text = portalText.lowercased()

        let needToTestPhrases = [
            "you are scheduled for a drug test today",
            "scheduled for a drug test today",
            "required to test today",
            "must test today",
            "you are required to test",
            "you must test"
        ]

        let noTestTodayPhrases = [
            "you are not scheduled to test today",
            "not scheduled to test today",
            "not scheduled for today",
            "no test today"
        ]

        if needToTestPhrases.contains(where: { phrase in
            text.contains(phrase)
        }) {
            return .needToTest
        }

        if noTestTodayPhrases.contains(where: { phrase in
            text.contains(phrase)
        }) {
            return .noTestToday
        }

        return .unknown
    }
}
