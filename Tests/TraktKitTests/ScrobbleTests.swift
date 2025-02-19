//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

@testable import TraktKit
import XCTest

class ScrobbleTests: XCTestCase {

    let session = MockURLSession()
    lazy var traktManager = TestTraktManager(session: session)

    override func tearDown() {
        super.tearDown()
        session.nextData = nil
        session.nextStatusCode = StatusCodes.Success
        session.nextError = nil
    }

    // MARK: - Start

    func test_start_watching_in_media_center() {
        session.nextData = jsonData(named: "test_start_watching_in_media_center")
        session.nextStatusCode = StatusCodes.SuccessNewResourceCreated

        let expectation = XCTestExpectation(description: "Start watching in media center")
        let scrobble = TraktScrobble(movie: SyncId(trakt: 12345), progress: 1.25)
        try! traktManager.scrobbleStart(scrobble) { result in
            if case let .success(response) = result {
                XCTAssertEqual(response.action, "start")
                XCTAssertEqual(response.progress, 1.25)
                XCTAssertNotNil(response.movie)
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/scrobble/start")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }

    // MARK: - Pause

    func test_pause_watching_in_media_center() {
        session.nextData = jsonData(named: "test_pause_watching_in_media_center")
        session.nextStatusCode = StatusCodes.SuccessNewResourceCreated

        let expectation = XCTestExpectation(description: "Pause watching in media center")
        let scrobble = TraktScrobble(movie: SyncId(trakt: 12345), progress: 75)
        try! traktManager.scrobblePause(scrobble) { result in
            if case let .success(response) = result {
                XCTAssertEqual(response.action, "pause")
                XCTAssertEqual(response.progress, 75)
                XCTAssertNotNil(response.movie)
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/scrobble/pause")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }

    // MARK: - Stop

    func test_stop_watching_in_media_center() {
        session.nextData = jsonData(named: "test_stop_watching_in_media_center")
        session.nextStatusCode = StatusCodes.SuccessNewResourceCreated

        let expectation = XCTestExpectation(description: "Stop watching in media center")
        let scrobble = TraktScrobble(movie: SyncId(trakt: 12345), progress: 99.9)
        try! traktManager.scrobbleStop(scrobble) { result in
            if case let .success(response) = result {
                XCTAssertEqual(response.action, "scrobble")
                XCTAssertEqual(response.progress, 99.9)
                XCTAssertNotNil(response.movie)
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/scrobble/stop")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }
}
