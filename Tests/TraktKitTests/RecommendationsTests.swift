//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

@testable import TraktKit
import XCTest

class RecommendationsTests: XCTestCase {

    let session = MockURLSession()
    lazy var traktManager = TestTraktManager(session: session)

    override func tearDown() {
        super.tearDown()
        session.nextData = nil
        session.nextStatusCode = StatusCodes.Success
        session.nextError = nil
    }

    // MARK: - Movies

    func test_get_movie_recommendations() {
        session.nextData = jsonData(named: "test_get_movie_recommendations")

        let expectation = XCTestExpectation(description: "Get movie recommendations")
        traktManager.getRecommendedMovies { result in
            if case let .success(movies) = result {
                XCTAssertEqual(movies.count, 10)
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/recommendations/movies")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }

    // MARK: - Hide Movie

    func test_hide_movie_recommendation() {
        session.nextStatusCode = StatusCodes.SuccessNoContentToReturn

        let expectation = XCTestExpectation(description: "Hide movie recommendation")
        traktManager.hideRecommendedMovie(movieID: 922) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/recommendations/movies/922")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }

    // MARK: - Shows

    func test_get_show_recommendations() {
        session.nextData = jsonData(named: "test_get_show_recommendations")

        let expectation = XCTestExpectation(description: "Get show recommendations")
        traktManager.getRecommendedShows { result in
            if case let .success(shows) = result {
                XCTAssertEqual(shows.count, 10)
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/recommendations/shows")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }

    // MARK: - Hide Show

    func test_hide_show_recommendation() {
        session.nextStatusCode = StatusCodes.SuccessNoContentToReturn

        let expectation = XCTestExpectation(description: "Hide show recommendation")
        traktManager.hideRecommendedShow(showID: 922) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(session.lastURL?.absoluteString, "https://api.trakt.tv/recommendations/shows/922")

        switch result {
        case .timedOut:
            XCTFail("Something isn't working")
        default:
            break
        }
    }
}
