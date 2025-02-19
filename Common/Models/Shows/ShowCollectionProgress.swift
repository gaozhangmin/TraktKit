//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct ShowCollectionProgress: Codable, Hashable {

    public let aired: Int
    public let completed: Int
    public let lastCollectedAt: Date
    public let seasons: [CollectedSeason]
    public let hiddenSeasons: [TraktSeason]
    public let nextEpisode: TraktEpisode?

    enum CodingKeys: String, CodingKey {
        case aired
        case completed
        case lastCollectedAt = "last_collected_at"
        case seasons
        case hiddenSeasons = "hidden_seasons"
        case nextEpisode = "next_episode"
    }

    public struct CollectedSeason: Codable, Hashable {
        public let number: Int
        public let aired: Int
        public let completed: Int
        public let episodes: [CollectedEpisode]
    }

    public struct CollectedEpisode: Codable, Hashable {
        public let number: Int
        public let completed: Bool
        public let collectedAt: Date?

        enum CodingKeys: String, CodingKey {
            case number
            case completed
            case collectedAt = "collected_at"
        }
    }
}
