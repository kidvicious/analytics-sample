//
//  Analytics_App_UserDefaultsTests.swift
//  Analytics-App-UserDefaultsTests
//
//  Created by Asmin Ghale on 7/7/24.
//

import XCTest
import Analytics_App_UserDefaults

final class Analytics_App_UserDefaultsTests: XCTestCase {

    var analytics: Analytics!

    override func setUp() {
        super.setUp()
        analytics = Analytics.shared
        // Clear any existing sessions for a clean slate
        analytics.sessions = []
    }

    override func tearDown() {
        super.tearDown()
        // Optionally clean up after each test if needed
    }

    func testStartNewSession() {
        // Ensure a new session is created if no current session exists
        analytics.stopSession()
        XCTAssert(analytics.currentSession == nil)
        
        analytics.start()
        XCTAssertNotNil(analytics.currentSession, "Expected a new session to be created")
    }

    func testTrackEvent() {
        // Track an event and verify it's added to the current session
        analytics.start()
        analytics.trackEvent(event: AppEvent.session("session testing"))

        XCTAssertNotNil(analytics.currentSession, "Expected a session to exist")
        XCTAssertEqual(analytics.currentSession?.events.count, 2, "Expected two events in the current session")
    }

    func testStopSession() {
        // Start a session, stop it, and verify it's saved correctly
        analytics.start()

        XCTAssertNotNil(analytics.currentSession, "Expected a session to exist")

        analytics.stopSession()
        XCTAssertNil(analytics.currentSession, "Current session will be nil")
        
        XCTAssertTrue(analytics.enabled)
    }


}
