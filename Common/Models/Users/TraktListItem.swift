//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktListItem: Codable, Hashable {
    public let rank: Int
    public let listedAt: Date
    public let type: String
    public var show: TraktShow? = nil
    public var season: TraktSeason? = nil
    public var episode: TraktEpisode? = nil
    public var movie: TraktMovie? = nil
    public var person: Person? = nil

    enum CodingKeys: String, CodingKey {
        case rank
        case listedAt = "listed_at"
        case type
        case show
        case season
        case episode
        case movie
        case person
    }
}
