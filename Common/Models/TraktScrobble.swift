//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktScrobble: Encodable {
    public let movie: SyncTmdbId?
    public let episode: SyncTmdbId?
    public let show: SyncTmdbId?
    /// Progress percentage between 0 and 100.
    public let progress: Float
    /// Version number of the app.
    public let appVersion: String?
    /// Build date of the app.
    public let appDate: String?

    enum CodingKeys: String, CodingKey {
        case movie
        case episode
        case show
        case progress
        case appVersion = "app_version"
        case appDate = "app_date"
    }

    public init(
        movie: SyncTmdbId? = nil,
        episode: SyncTmdbId? = nil,

        show: SyncTmdbId? = nil,
        progress: Float,
        appVersion: String? = nil,
        appDate: String? = nil
    ) {
        self.movie = movie
        self.episode = episode
        self.show = show
        self.progress = progress
        self.appVersion = appVersion
        self.appDate = appDate
    }
}

public struct TraktScrobbleWithEpisodeNum: Encodable {
    public let episode: SyncIdWithSeasonAndEpisodeNum?
    public let show: SyncTmdbId?
    /// Progress percentage between 0 and 100.
    public let progress: Float

    enum CodingKeys: String, CodingKey {
        case episode
        case show
        case progress
    }

    public init(
        episode: SyncIdWithSeasonAndEpisodeNum? = nil,
        show: SyncTmdbId? = nil,
        progress: Float
    ) {
        self.episode = episode
        self.show = show
        self.progress = progress
    }
}
