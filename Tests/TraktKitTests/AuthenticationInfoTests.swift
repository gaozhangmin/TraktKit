//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

@testable import TraktKit
import XCTest

class AuthenticationInfoTests: XCTestCase {

    func testParsingAuthenticationInfo() {
        let authenticationInfo = decode("AuthenticationInfo", to: AuthenticationInfo.self)!
        XCTAssertEqual(authenticationInfo.accessToken, "dbaf9757982a9e738f05d249b7b5b4a266b3a139049317c4909f2f263572c781")
        XCTAssertEqual(authenticationInfo.tokenType, "bearer")
        XCTAssertEqual(authenticationInfo.expiresIn, 7200)
        XCTAssertEqual(authenticationInfo.refreshToken, "76ba4c5c75c96f6087f58a4de10be6c00b29ea1ddc3b2022ee2016d1363e3a7c")
        XCTAssertEqual(authenticationInfo.scope, "public")
        XCTAssertEqual(authenticationInfo.createdAt, 1_487_889_741)
    }
}
