//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation
@testable import TraktKit
import XCTest

class JSONEncodingTests: XCTestCase {

    let jsonEncoder = TraktManager.sharedManager.jsonEncoder

    func testEncodeShowIds() {
        let expectation: RawJSON = [
            "episodes": [
                [
                    "ids": [
                        "trakt": 12345,
                    ],
                ],
            ],
        ]

        let object = TraktMediaBody(episodes: [SyncId(trakt: 12345)])

        do {
            let data = try jsonEncoder.encode(object)
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? RawJSON else {
                XCTFail("Failed to decode JSON")
                return
            }
            XCTAssertEqual(NSDictionary(dictionary: json), NSDictionary(dictionary: expectation))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testEncodeHistoryIds() {
        let watchedDate = Date()
        let expectation: RawJSON = [
            "episodes": [
                [
                    "ids": [
                        "trakt": 12345,
                    ],
                    "watched_at": watchedDate.dateString(withFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'"),
                ],
            ],
            "ids": [
                12345,
            ],
        ]
        let object = TraktMediaBody<AddToHistoryId>(episodes: [AddToHistoryId(trakt: 12345, watchedAt: watchedDate)], ids: [12345])

        do {
            let data = try jsonEncoder.encode(object)
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? RawJSON else {
                XCTFail("Failed to decode JSON")
                return
            }
            XCTAssertEqual(NSDictionary(dictionary: json), NSDictionary(dictionary: expectation))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testEncodeMovieAndShowIds() {
        let expectation: RawJSON = [
            "movies": [
                [
                    "ids": [
                        "trakt": 12345,
                    ],
                ],
            ],
            "shows": [
                [
                    "ids": [
                        "trakt": 12345,
                    ],
                ],
            ],
        ]
        let object = TraktMediaBody(movies: [SyncId(trakt: 12345)], shows: [SyncId(trakt: 12345)])

        do {
            let data = try jsonEncoder.encode(object)
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? RawJSON else {
                XCTFail("Failed to decode JSON")
                return
            }
            XCTAssertEqual(NSDictionary(dictionary: json), NSDictionary(dictionary: expectation))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
