//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

/// Watched progress. Shows/Progress/Watched
public struct TraktShowWatchedProgress: Codable, Hashable {

    // Extended: Min
    /// Number of episodes that have aired
    public let aired: Int
    /// Number of episodes that have been watched
    public let completed: Int
    /// When the last episode was watched
    public let lastWatchedAt: Date?
    public let seasons: [TraktSeasonWatchedProgress]
    public let nextEpisode: TraktEpisode?

    enum CodingKeys: String, CodingKey {
        case aired
        case completed
        case lastWatchedAt = "last_watched_at"
        case seasons
        case nextEpisode = "next_episode"
    }
}

public struct TraktSeasonWatchedProgress: Codable, Hashable {

    // Extended: Min
    /// Season number
    public let number: Int
    /// Number of episodes that have aired
    public let aired: Int
    /// Number of episodes that have been watched
    public let completed: Int
    public let episodes: [TraktEpisodeWatchedProgress]
}

public struct TraktEpisodeWatchedProgress: Codable, Hashable {

    // Extended: Min
    /// Season number
    public let number: Int
    /// Has this episode been watched
    public let completed: Bool
    /// When the last episode was watched
    public let lastWatchedAt: Date?

    enum CodingKeys: String, CodingKey {
        case number
        case completed
        case lastWatchedAt = "last_watched_at"
    }
}
