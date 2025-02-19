//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktWatchedShow: Codable, Hashable {

    // Extended: Min
    public let plays: Int // Total number of plays
    public let lastWatchedAt: Date?
    public let lastUpdatedAt: Date?
    public let show: TraktShow
    public let seasons: [TraktWatchedSeason]?

    enum CodingKeys: String, CodingKey {
        case plays
        case lastWatchedAt = "last_watched_at"
        case lastUpdatedAt = "last_updated_at"
        case show
        case seasons
    }

    public init(plays: Int, lastWatchedAt: Date?, lastUpdatedAt: Date?, show: TraktShow, seasons: [TraktWatchedSeason]?) {
        self.plays = plays
        self.lastWatchedAt = lastWatchedAt
        self.lastUpdatedAt = lastUpdatedAt
        self.show = show
        self.seasons = seasons
    }
}
