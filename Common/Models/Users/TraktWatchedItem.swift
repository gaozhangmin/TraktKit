//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktWatchedItem: Codable, Hashable {
    public let plays: Int
    public let lastWatchedAt: Date
    public var show: TraktShow? = nil
    public var seasons: [TraktWatchedSeason]? = nil
    public var movie: TraktMovie? = nil

    enum CodingKeys: String, CodingKey {
        case plays
        case lastWatchedAt = "last_watched_at"
        case show
        case seasons
        case movie
    }
}
