//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct SeasonResource {
    public let showId: CustomStringConvertible
    public let seasonNumber: Int
    public let traktManager: TraktManager

    init(showId: CustomStringConvertible, seasonNumber: Int, traktManager: TraktManager = .sharedManager) {
        self.showId = showId
        self.seasonNumber = seasonNumber
        self.traktManager = traktManager
    }

    // MARK: - Methods

    public func summary() async throws -> Route<TraktSeason> {
        try await traktManager.get("shows/\(showId)/seasons/\(seasonNumber)")
    }

    public func comments() async throws -> Route<[Comment]> {
        try await traktManager.get("shows/\(showId)/seasons/\(seasonNumber)/comments")
    }

    // MARK: - Resources

    public func episode(_ number: Int) -> EpisodeResource {
        EpisodeResource(
            showId: showId,
            seasonNumber: seasonNumber,
            episodeNumber: number,
            traktManager: traktManager
        )
    }
}
