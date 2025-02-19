//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct EpisodeResource {
    public let showId: CustomStringConvertible
    public let seasonNumber: Int
    public let episodeNumber: Int
    public let traktManager: TraktManager
    private let path: String

    init(showId: CustomStringConvertible, seasonNumber: Int, episodeNumber: Int, traktManager: TraktManager = .sharedManager) {
        self.showId = showId
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        self.traktManager = traktManager
        self.path = "shows/\(showId)/seasons/\(seasonNumber)/episodes/\(episodeNumber)"
    }

    public func summary() async throws -> Route<TraktEpisode> {
        try await traktManager.get(path)
    }

    public func comments() async throws -> Route<[Comment]> {
        try await traktManager.get(path + "/comments")
    }

    public func people() async throws -> Route<CastAndCrew<TVCastMember, TVCrewMember>> {
        try await traktManager.get(path + "/people")
    }
}
