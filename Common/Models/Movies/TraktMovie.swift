//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktMovie: Codable, Hashable {

    // Extended: Min
    public let title: String
    public let year: Int?
    public let ids: ID

    // Extended: Full
    public let tagline: String?
    public let overview: String?
    public let released: Date?
    public let runtime: Int?
    public let trailer: URL?
    public let homepage: URL?
    public let rating: Double?
    public let votes: Int?
    public let updatedAt: Date?
    public let language: String?
    public let availableTranslations: [String]?
    public let genres: [String]?
    public let certification: String?

    enum CodingKeys: String, CodingKey {
        case title
        case year
        case ids

        case tagline
        case overview
        case released
        case runtime
        case trailer
        case homepage
        case rating
        case votes
        case updatedAt = "updated_at"
        case language
        case availableTranslations = "available_translations"
        case genres
        case certification
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        year = try container.decodeIfPresent(Int.self, forKey: CodingKeys.year)
        ids = try container.decode(ID.self, forKey: CodingKeys.ids)

        tagline = try container.decodeIfPresent(String.self, forKey: CodingKeys.tagline)
        overview = try container.decodeIfPresent(String.self, forKey: CodingKeys.overview)
        released = try container.decodeIfPresent(Date.self, forKey: CodingKeys.released)
        runtime = try container.decodeIfPresent(Int.self, forKey: CodingKeys.runtime)
        certification = try container.decodeIfPresent(String.self, forKey: .certification)
        trailer = try? container.decode(URL.self, forKey: .trailer)
        homepage = try? container.decode(URL.self, forKey: .homepage)
        rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        votes = try container.decodeIfPresent(Int.self, forKey: .votes)
        updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        language = try container.decodeIfPresent(String.self, forKey: .language)
        availableTranslations = try container.decodeIfPresent([String].self, forKey: .availableTranslations)
        genres = try container.decodeIfPresent([String].self, forKey: .genres)
    }

    public init(
        title: String,
        year: Int? = nil,
        ids: ID,
        tagline: String? = nil,
        overview: String? = nil,
        released: Date? = nil,
        runtime: Int? = nil,
        trailer: URL? = nil,
        homepage: URL? = nil,
        rating: Double? = nil,
        votes: Int? = nil,
        updatedAt: Date? = nil,
        language: String? = nil,
        availableTranslations: [String]? = nil,
        genres: [String]? = nil,
        certification: String? = nil
    ) {
        self.title = title
        self.year = year
        self.ids = ids
        self.tagline = tagline
        self.overview = overview
        self.released = released
        self.runtime = runtime
        self.trailer = trailer
        self.homepage = homepage
        self.rating = rating
        self.votes = votes
        self.updatedAt = updatedAt
        self.language = language
        self.availableTranslations = availableTranslations
        self.genres = genres
        self.certification = certification
    }
}
