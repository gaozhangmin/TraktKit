//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktWatchedEpisodes: Codable, Hashable {
    // Extended: Min
    public let number: Int
    public let plays: Int
    public let lastWatchedAt: Date?

    enum CodingKeys: String, CodingKey {
        case number
        case plays
        case lastWatchedAt = "last_watched_at"
    }
}
