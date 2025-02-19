//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

/// Body data for endpoints like `/sync/history` that contains Trakt Ids.
struct TraktMediaBody<ID: Encodable>: Encodable {
    let movies: [ID]?
    let shows: [ID]?
    let seasons: [ID]?
    let episodes: [ID]?
    let ids: [Int]?
    let people: [ID]?

    init(movies: [ID]? = nil, shows: [ID]? = nil, seasons: [ID]? = nil, episodes: [ID]? = nil, ids: [Int]? = nil, people: [ID]? = nil) {
        self.movies = movies
        self.shows = shows
        self.seasons = seasons
        self.episodes = episodes
        self.ids = ids
        self.people = people
    }
}

/// Data for containing a single object
class TraktSingleObjectBody<ID: Encodable>: Encodable {
    let movie: ID?
    let show: ID?
    let season: ID?
    let episode: ID?
    let list: ID?

    init(movie: ID? = nil, show: ID? = nil, season: ID? = nil, episode: ID? = nil, list: ID? = nil) {
        self.movie = movie
        self.show = show
        self.season = season
        self.episode = episode
        self.list = list
    }
}

class TraktCommentBody: TraktSingleObjectBody<SyncTmdbId> {
    let comment: String
    let spoiler: Bool?

    init(
        movie: SyncTmdbId? = nil,
        show: SyncTmdbId? = nil,
        season: SyncTmdbId? = nil,
        episode: SyncTmdbId? = nil,
        list: SyncTmdbId? = nil,
        comment: String,
        spoiler: Bool?
    ) {
        self.comment = comment
        self.spoiler = spoiler
        super.init(movie: movie, show: show, season: season, episode: episode, list: list)
    }
}

/// ID used to sync with Trakt.
public struct SyncId: Codable, Hashable {
    /// Trakt id of the movie / show / season / episode
    public let trakt: Int

    enum CodingKeys: String, CodingKey {
        case ids
    }

    enum IDCodingKeys: String, CodingKey {
        case trakt
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nested = container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .ids)
        try nested.encode(trakt, forKey: .trakt)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nested = try container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .ids)
        self.trakt = try nested.decode(Int.self, forKey: .trakt)
    }

    public init(trakt: Int) {
        self.trakt = trakt
    }
}

public struct EpisodeWithRating: Codable, Hashable {
    /// Season number
    public let rating: Int
    /// Episode number
    public let number: Int

    enum CodingKeys: String, CodingKey {
        case rating
        case number
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rating, forKey: .rating)
        try container.encode(number, forKey: .number)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.number = try container.decode(Int.self, forKey: .number)
    }

    public init(rating: Int, number: Int) {
        self.rating = rating
        self.number = number
    }
}

public struct SeasonWithRating: Codable, Hashable {
    /// Season number
    public let episodes: [EpisodeWithRating]?
    public let rating: Int?
    /// Episode number
    public let number: Int

    enum CodingKeys: String, CodingKey {
        case episodes
        case number
        case rating
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(episodes, forKey: .episodes)
        try container.encode(number, forKey: .number)
        try container.encodeIfPresent(rating, forKey: .rating)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.episodes = try container.decodeIfPresent([EpisodeWithRating].self, forKey: .episodes)
        self.number = try container.decode(Int.self, forKey: .number)
        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating)
    }

    public init(episodes: [EpisodeWithRating]?, number: Int, rating: Int?) {
        self.episodes = episodes
        self.number = number
        self.rating = rating
    }
}

public struct SyncIdWithSeasonAndEpisodeNum: Codable, Hashable {
    /// Season number
    public let season: Int
    /// Episode number
    public let number: Int

    enum CodingKeys: String, CodingKey {
        case season
        case number
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(season, forKey: .season)
        try container.encode(number, forKey: .number)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.season = try container.decode(Int.self, forKey: .season)
        self.number = try container.decode(Int.self, forKey: .number)
    }

    public init(season: Int, number: Int) {
        self.season = season
        self.number = number
    }
}

public struct SyncTmdbId: Codable, Hashable {
    public let tmdb: Int

    enum CodingKeys: String, CodingKey {
        case ids
    }

    enum IDCodingKeys: String, CodingKey {
        case tmdb
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nested = container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .ids)
        try nested.encode(tmdb, forKey: .tmdb)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nested = try container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .ids)
        self.tmdb = try nested.decode(Int.self, forKey: .tmdb)
    }

    public init(tmdb: Int) {
        self.tmdb = tmdb
    }
}

public struct AddToHistoryId: Encodable, Hashable {
    /// Trakt id of the movie / show / season / episode
    public let trakt: Int
    /// UTC datetime when the item was watched.
    public let watchedAt: Date?

    enum CodingKeys: String, CodingKey {
        case ids
        case watchedAt = "watched_at"
    }

    enum IDCodingKeys: String, CodingKey {
        case trakt
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nested = container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .ids)
        try nested.encode(trakt, forKey: .trakt)
        try container.encodeIfPresent(watchedAt, forKey: .watchedAt)
    }

    public init(trakt: Int, watchedAt: Date?) {
        self.trakt = trakt
        self.watchedAt = watchedAt
    }
}

public struct RatingId: Encodable, Hashable {
    /// Trakt id of the movie / show / season / episode
    public let tmdb: Int
    /// Between 1 and 10.
    public let rating: Int
    /// UTC datetime when the item was rated.
    public let ratedAt: Date?

    enum CodingKeys: String, CodingKey {
        case ids
        case rating
        case ratedAt = "rated_at"
    }

    enum IDCodingKeys: String, CodingKey {
        case tmdb
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nested = container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .ids)
        try nested.encode(tmdb, forKey: .tmdb)
        try container.encode(rating, forKey: .rating)
        try container.encodeIfPresent(ratedAt, forKey: .ratedAt)
    }

    public init(tmdb: Int, rating: Int, ratedAt: Date?) {
        self.tmdb = tmdb
        self.rating = rating
        self.ratedAt = ratedAt
    }
}

public struct CollectionId: Encodable, Hashable {
    /// Trakt id of the movie / show / season / episode
    public let trakt: Int
    /// UTC datetime when the item was collected. Set to `released` to automatically use the inital release date.
    public let collectedAt: Date
    public let mediaType: TraktCollectedItem.MediaType?
    public let resolution: TraktCollectedItem.Resolution?
    public let hdr: TraktCollectedItem.HDR?
    public let audio: TraktCollectedItem.Audio?
    public let audioChannels: TraktCollectedItem.AudioChannels?
    /// Set true if in 3D.
    public let is3D: Bool?

    enum CodingKeys: String, CodingKey {
        case ids
        case collectedAt = "collected_at"
        case mediaType = "media_type"
        case resolution
        case hdr
        case audio
        case audioChannels = "audio_channels"
        case is3D = "3d"
    }

    enum IDCodingKeys: String, CodingKey {
        case trakt
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nested = container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .ids)
        try nested.encode(trakt, forKey: .trakt)
        try container.encode(collectedAt, forKey: .collectedAt)
        try container.encodeIfPresent(mediaType, forKey: .mediaType)
        try container.encodeIfPresent(resolution, forKey: .resolution)
        try container.encodeIfPresent(hdr, forKey: .hdr)
        try container.encodeIfPresent(audio, forKey: .audio)
        try container.encodeIfPresent(audioChannels, forKey: .audioChannels)
        try container.encodeIfPresent(is3D, forKey: .is3D)
    }

    public init(
        trakt: Int,
        collectedAt: Date,
        mediaType: TraktCollectedItem.MediaType? = nil,
        resolution: TraktCollectedItem.Resolution? = nil,
        hdr: TraktCollectedItem.HDR? = nil,
        audio: TraktCollectedItem.Audio? = nil,
        audioChannels: TraktCollectedItem.AudioChannels? = nil,
        is3D: Bool? = nil
    ) {
        self.trakt = trakt
        self.collectedAt = collectedAt
        self.mediaType = mediaType
        self.resolution = resolution
        self.hdr = hdr
        self.audio = audio
        self.audioChannels = audioChannels
        self.is3D = is3D
    }
}

public struct EpisodeRatingsData: Encodable {
    public struct Ids: Encodable, Hashable {
        public let tmdb: Int
    }

    public let ids: Ids
    public let seasons: [SeasonWithRating]?
    public let rating: Int?

    enum CodingKeys: String, CodingKey {
        case ids
        case rating
        case seasons
    }

    public init(tmdbId: Int, rating: Int?, seasons: [SeasonWithRating]?) {
        self.ids = Ids(tmdb: tmdbId)
        self.rating = rating
        self.seasons = seasons
    }
}

public struct TraktPostDataV2: Encodable, Hashable {
    public struct Ids: Encodable, Hashable {
        public let tmdb: Int
    }

    public let ids: Ids
    public let seasons: [SeasonWithWatchedAt]?
    public let watchedAt: Date?

    enum CodingKeys: String, CodingKey {
        case ids
        case watchedAt = "watched_at"
        case seasons
    }

    public init(tmdbId: Int, watchedAt: Date?, seasons: [SeasonWithWatchedAt]?) {
        self.ids = Ids(tmdb: tmdbId)
        self.watchedAt = watchedAt
        self.seasons = seasons
    }
}

public struct SeasonWithWatchedAt: Codable, Hashable {
    /// Season number
    public let episodes: [EpisodeWithWatchedAt]?
    /// Episode number
    public let watchedAt: Date?
    public let number: Int

    enum CodingKeys: String, CodingKey {
        case episodes
        case number
        case watchedAt = "watched_at"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(episodes, forKey: .episodes)
        try container.encode(number, forKey: .number)
        try container.encodeIfPresent(watchedAt, forKey: .watchedAt)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.episodes = try container.decodeIfPresent([EpisodeWithWatchedAt].self, forKey: .episodes)
        self.number = try container.decode(Int.self, forKey: .number)
        self.watchedAt = try container.decodeIfPresent(Date.self, forKey: .watchedAt)
    }

    public init(episodes: [EpisodeWithWatchedAt]?, number: Int, watchedAt: Date?) {
        self.episodes = episodes
        self.number = number
        self.watchedAt = watchedAt
    }
}

public struct EpisodeWithWatchedAt: Codable, Hashable {
    /// Season number
    public let watchedAt: Date?
    /// Episode number
    public let number: Int

    enum CodingKeys: String, CodingKey {
        case watchedAt = "watched_at"
        case number
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(watchedAt, forKey: .watchedAt)
        try container.encode(number, forKey: .number)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.watchedAt = try container.decodeIfPresent(Date.self, forKey: .watchedAt)
        self.number = try container.decode(Int.self, forKey: .number)
    }

    public init(watchedAt: Date?, number: Int) {
        self.watchedAt = watchedAt
        self.number = number
    }
}
