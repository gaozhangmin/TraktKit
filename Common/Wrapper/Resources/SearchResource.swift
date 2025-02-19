//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct SearchResource {

    // MARK: - Properties

    public let traktManager: TraktManager

    // MARK: - Lifecycle

    public init(traktManager: TraktManager = .sharedManager) {
        self.traktManager = traktManager
    }

    // MARK: - Actions

    public func search(
        _ query: String,
        types: [SearchType] // = [.movie, .show, .episode, .person, .list]
    ) async throws -> Route<[TraktSearchResult]> {
        let searchTypes = types.map(\.rawValue).joined(separator: ",")
        return try await traktManager.get("search/\(searchTypes)", resultType: [TraktSearchResult].self).query(query)
    }

    public func lookup(_ id: LookupType) async throws -> Route<[TraktSearchResult]> {
        try await traktManager.get("search/\(id.name)/\(id.id)")
    }
}
