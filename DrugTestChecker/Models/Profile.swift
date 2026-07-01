//
//  Profile.swift
//  DrugTestChecker/Models
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import Foundation
import SwiftData

@Model
final class Profile {
    var profileName: String
    var lastName: String
    var pin: String
    var dailyCheckTime: Date
    var reminderCadenceMinutes: Int
    var rememberCredentials: Bool
    var createdAt: Date
    var updatedAt: Date

    init(
        profileName: String = "",
        lastName: String = "",
        pin: String = "",
        dailyCheckTime: Date = .now,
        reminderCadenceMinutes: Int = 30,
        rememberCredentials: Bool = false,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.profileName = profileName
        self.lastName = lastName
        self.pin = pin
        self.dailyCheckTime = dailyCheckTime
        self.reminderCadenceMinutes = reminderCadenceMinutes
        self.rememberCredentials = rememberCredentials
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
