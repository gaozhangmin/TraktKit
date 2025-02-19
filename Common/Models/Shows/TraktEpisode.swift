//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktEpisode: Codable, Hashable {

    // Extended: Min
    public let season: Int
    public let number: Int
    public let title: String?
    public let ids: EpisodeId

    // Extended: Full
    public let overview: String?
    public let rating: Double?
    public let votes: Int?
    public let firstAired: Date?
    public let updatedAt: Date?
    public let availableTranslations: [String]?
    public let absoluteNumber: Int?
    public let runtime: Int?
    public let commentCount: Int?

    enum CodingKeys: String, CodingKey {
        case season
        case number
        case title
        case ids

        case overview
        case rating
        case votes
        case firstAired = "first_aired"
        case updatedAt = "updated_at"
        case availableTranslations = "available_translations"
        case absoluteNumber = "number_abs"
        case runtime
        case commentCount = "comment_count"
    }

    public init(
        season: Int,
        number: Int,
        title: String? = nil,
        ids: EpisodeId,
        overview: String? = nil,
        rating: Double? = nil,
        votes: Int? = nil,
        firstAired: Date? = nil,
        updatedAt: Date? = nil,
        availableTranslations: [String]? = nil,
        absoluteNumber: Int? = nil,
        runtime: Int? = nil,
        commentCount: Int? = nil
    ) {
        self.season = season
        self.number = number
        self.title = title
        self.ids = ids
        self.overview = overview
        self.rating = rating
        self.votes = votes
        self.firstAired = firstAired
        self.updatedAt = updatedAt
        self.availableTranslations = availableTranslations
        self.absoluteNumber = absoluteNumber
        self.runtime = runtime
        self.commentCount = commentCount
    }
}
