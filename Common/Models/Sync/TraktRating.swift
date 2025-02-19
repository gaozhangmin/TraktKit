//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktRating: Codable, Hashable {
    public var ratedAt: Date
    public var rating: Int

    public var movie: TraktMovie?
    public var show: TraktShow?
    public var season: TraktSeason?
    public var episode: TraktEpisode?

    enum CodingKeys: String, CodingKey {
        case ratedAt = "rated_at"
        case rating
        case movie
        case show
        case season
        case episode
    }
}
