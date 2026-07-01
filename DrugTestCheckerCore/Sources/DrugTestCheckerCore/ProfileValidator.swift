//
//  ProfileValidator.swift
//  DrugTestCheckerCore
//
//  Created by Taylor Vance Parker on 6/25/26.
//
import Foundation

public enum ProfileValidator {
    public static func isValidPIN(_ pin: String) -> Bool {
        pin.count == 7 && pin.allSatisfy { $0.isNumber }
    }

    public static func lastNameCode(from lastName: String) -> String {
        let cleaned = lastName
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .filter { $0.isLetter }
            .uppercased()

        return String(cleaned.prefix(4))
    }
}
