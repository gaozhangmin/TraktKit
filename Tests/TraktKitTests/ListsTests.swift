//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

@testable import TraktKit
import XCTest

class ListsTests: XCTestCase {

    let session = MockURLSession()
    lazy var traktManager = TestTraktManager(session: session)

    override func tearDown() {
        super.tearDown()
        session.nextData = nil
        session.nextStatusCode = StatusCodes.Success
        session.nextError = nil
    }

    func test_get_trending_lists() {
        session.nextData = jsonData(named: "test_get_trending_lists")

        let expectation = XCTestExpectation(description: "Get trending lists")
        traktManager.getTrendingLists { result in
            if case let .success(lists) = result {
                XCTAssertEqual(lists.count, 2)
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/lists/trending")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }

    func test_get_popular_lists() {
        session.nextData = jsonData(named: "test_get_popular_lists")

        let expectation = XCTestExpectation(description: "Get popular lists")
        traktManager.getPopularLists { result in
            if case let .success(lists) = result {
                XCTAssertEqual(lists.count, 2)
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/lists/popular")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }
}
