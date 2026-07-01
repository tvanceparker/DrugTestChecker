//
//  ProfileView.swift
//  DrugTestChecker/Views
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import SwiftUI
import SwiftData
import DrugTestCheckerCore


struct ProfileView: View {
    @Binding var selectedTab: Int
    @State private var didSave = false
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [Profile]

    @State private var profileName = ""
    @State private var pin = ""
    @State private var lastName = ""
    @State private var dailyCheckTime = Date()
    @State private var reminderCadenceMinutes = 30
    @State private var rememberCredentials = false

    private var existingProfile: Profile? {
        profiles.first
    }

    private var lastNameCode: String {
        ProfileValidator.lastNameCode(from: lastName)
    }

    private var isPINValid: Bool {
        ProfileValidator.isValidPIN(pin)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Profile") {
                    TextField("Profile Name", text: $profileName)
                    TextField("PIN", text: $pin)
                        .keyboardType(.numberPad)
                    TextField("Last Name", text: $lastName)

                    Toggle("Remember Credentials", isOn: $rememberCredentials)

                    LabeledContent("Last Name Code") {
                        Text(lastNameCode.isEmpty ? "—" : lastNameCode)
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Schedule") {
                    DatePicker("Daily Check Time", selection: $dailyCheckTime, displayedComponents: .hourAndMinute)

                    Stepper("Reminder Cadence: \(reminderCadenceMinutes) min", value: $reminderCadenceMinutes, in: 15...120, step: 15)
                }

                Section("Validation") {
                    LabeledContent("PIN") {
                        Text(isPINValid ? "Valid" : "Needs 7 digits")
                            .foregroundStyle(isPINValid ? .green : .orange)
                    }
                }
                if didSave{
                    Section {
                        Label("Profile Saved", systemImage: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                }
                Section {
                    Button("Save Profile") {
                        saveProfile()
                    }
                    .disabled(!isPINValid || lastNameCode.isEmpty)
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                loadProfile()
            }
        }
    }

    private func loadProfile() {
        guard let profile = existingProfile else { return }

        profileName = profile.profileName
        pin = profile.pin
        lastName = profile.lastName
        dailyCheckTime = profile.dailyCheckTime
        reminderCadenceMinutes = profile.reminderCadenceMinutes
        rememberCredentials = profile.rememberCredentials
    }

    private func saveProfile() {
        let profile = existingProfile ?? Profile()

        profile.profileName = profileName
        profile.pin = pin
        profile.lastName = lastName
        profile.dailyCheckTime = dailyCheckTime
        profile.reminderCadenceMinutes = reminderCadenceMinutes
        profile.rememberCredentials = rememberCredentials
        profile.updatedAt = .now

        if existingProfile == nil {
            modelContext.insert(profile)
        }

        do {
            try modelContext.save()
            didSave = true
            selectedTab = 0
        } catch {
            print("Failed to save profile: \(error)")
        }
    }
}
