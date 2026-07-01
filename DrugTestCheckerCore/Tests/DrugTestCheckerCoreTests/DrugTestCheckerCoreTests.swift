import Testing
@testable import DrugTestCheckerCore

@Test func statusDisplayTitlesAreCorrect() {
    #expect(DrugTestStatus.notChecked.displayTitle == "Not Checked")
    #expect(DrugTestStatus.noTestToday.displayTitle == "No Test Today")
    #expect(DrugTestStatus.needToTest.displayTitle == "Need to Test")
    #expect(DrugTestStatus.completedTest.displayTitle == "Test Completed")
    #expect(DrugTestStatus.error.displayTitle == "Check Error")
    #expect(DrugTestStatus.unknown.displayTitle == "Unknown Result")
}

@Test func statusColorTokensAreCorrect() {
    #expect(DrugTestStatus.notChecked.colorToken == .amber)
    #expect(DrugTestStatus.noTestToday.colorToken == .green)
    #expect(DrugTestStatus.needToTest.colorToken == .red)
    #expect(DrugTestStatus.completedTest.colorToken == .green)
    #expect(DrugTestStatus.error.colorToken == .amber)
    #expect(DrugTestStatus.unknown.colorToken == .amber)
}

@Test func parsesNeedToTestMessage() {
    let status = PortalResultParser.parseStatus(
        from: "You are required to test today."
    )

    #expect(status == .needToTest)
}

@Test func parsesNoTestTodayMessage() {
    let status = PortalResultParser.parseStatus(
        from: "A drug test is not scheduled for today, June 20."
    )

    #expect(status == .noTestToday)
}

@Test func parsesUnknownMessage() {
    let status = PortalResultParser.parseStatus(
        from: "Unable to find your record."
    )

    #expect(status == .unknown)
}

@Test func validatesSevenDigitPIN() {
    #expect(ProfileValidator.isValidPIN("1234567") == true)
    #expect(ProfileValidator.isValidPIN("123456") == false)
    #expect(ProfileValidator.isValidPIN("12345678") == false)
    #expect(ProfileValidator.isValidPIN("12345AB") == false)
}

@Test func createsLastNameCode() {
    #expect(ProfileValidator.lastNameCode(from: "Parker") == "PARK")
    #expect(ProfileValidator.lastNameCode(from: "Lee") == "LEE")
    #expect(ProfileValidator.lastNameCode(from: "  o'neal  ") == "ONEA")
}
