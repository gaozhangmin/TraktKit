//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

/**
 Some methods are paginated. By default, 1 page of 10 items will be returned. You can send these values by adding `?page={page}&limit={limit}` to the URL.
 */
public struct Pagination: Hashable {
    /// Number of page of results to be returned.
    public let page: Int
    /// Number of results to return per page.
    public let limit: Int

    public init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }

    public func value() -> [(key: String, value: String)] {
        [
            ("page", "\(self.page)"),
            ("limit", "\(self.limit)"),
        ]
    }
}
