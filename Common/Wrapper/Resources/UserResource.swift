//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension TraktManager {
    /// Resource for authenticated user
    struct CurrentUserResource {
        public let traktManager: TraktManager

        init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        // MARK: - Methods

        public func settings() async throws -> Route<AccountSettings> {
            try await traktManager.get("users/settings", authorized: true)
        }
    }

    /// Resource for /Users/id
    struct UsersResource {

        public let username: String
        public let traktManager: TraktManager

        init(username: String, traktManager: TraktManager = .sharedManager) {
            self.username = username
            self.traktManager = traktManager
        }

        // MARK: - Methods

        public func lists() async throws -> Route<[TraktList]> {
            try await traktManager.get("users/\(username)/lists")
        }

        public func itemsOnList(_ listId: String, type: ListItemType? = nil) async throws -> Route<[TraktListItem]> {
            if let type = type {
                return try await traktManager.get("users/\(username)/lists/\(listId)/items/\(type.rawValue)")
            } else {
                return try await traktManager.get("users/\(username)/lists/\(listId)/items")
            }
        }
    }
}
