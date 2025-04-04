//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension TraktManager {

    // MARK: - Summary

    /**
     Returns a single episode's details. All date and times are in UTC and were calculated using the episode's `air_date` and show's `country` and `air_time`.

     **Note**: If the `first_aired` is unknown, it will be set to `null`.
     */
    @discardableResult
    func getEpisodeSummary<T: CustomStringConvertible>(
        showID id: T,
        seasonNumber season: NSNumber,
        episodeNumber episode: NSNumber,
        extended: [ExtendedType] = [.Min],
        completion: @escaping ObjectCompletionHandler<TraktEpisode>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/episodes/\(episode)",
            withQuery: ["extended": extended.queryString()],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Translations

    /**
     Returns all translations for an episode, including language and translated values for title and overview.

     - parameter showID: Trakt.tv ID, Trakt.tv slug, or IMDB ID
     - parameter seasonNumber: season number
     - parameter episodeNumber: episode number
     - parameter language: 2 character language code
     */
    @discardableResult
    func getEpisodeTranslations<T: CustomStringConvertible>(
        showID id: T,
        seasonNumber season: NSNumber,
        episodeNumber episode: NSNumber,
        language: String? = nil,
        completion: @escaping ObjectsCompletionHandler<TraktEpisodeTranslation>
    ) -> URLSessionDataTaskProtocol? {
        var path = "shows/\(id)/seasons/\(season)/episodes/\(episode)/translations"
        if let language = language {
            path += "/\(language)"
        }

        guard let request = mutableRequest(
            forPath: path,
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Comments

    /**
     Returns all top level comments for an episode. Most recent comments returned first.

     📄 Pagination
     */
    @discardableResult
    func getEpisodeComments<T: CustomStringConvertible>(
        showID id: T,
        seasonNumber season: NSNumber,
        episodeNumber episode: NSNumber,
        pagination: Pagination? = nil,
        completion: @escaping CommentsCompletionHandler
    ) -> URLSessionDataTaskProtocol? {

        var query: [String: String] = [:]

        // pagination
        if let pagination = pagination {
            for (key, value) in pagination.value() {
                query[key] = value
            }
        }

        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/episodes/\(episode)/comments",
            withQuery: query,
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Lists

    /**
     Returns all lists that contain this episode. By default, `personal` lists are returned sorted by the most `popular`.

     📄 Pagination
     */
    @discardableResult
    func getListsContainingEpisode<T: CustomStringConvertible>(
        showID id: T,
        seasonNumber season: NSNumber,
        episodeNumber episode: NSNumber,
        listType: ListType? = nil,
        sortBy: ListSortType? = nil,
        pagination: Pagination? = nil,
        completion: @escaping paginatedCompletionHandler<TraktList>
    ) -> URLSessionDataTaskProtocol? {
        var path = "shows/\(id)/seasons/\(season)/episodes/\(episode)/lists"
        if let listType = listType {
            path += "/\(listType)"

            if let sortBy = sortBy {
                path += "/\(sortBy)"
            }
        }

        var query: [String: String] = [:]

        // pagination
        if let pagination = pagination {
            for (key, value) in pagination.value() {
                query[key] = value
            }
        }

        guard let request = mutableRequest(
            forPath: path,
            withQuery: query,
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Ratings

    /**
     Returns rating (between 0 and 10) and distribution for an episode.
     */
    @discardableResult
    func getEpisodeRatings<T: CustomStringConvertible>(
        showID id: T,
        seasonNumber: NSNumber,
        episodeNumber: NSNumber,
        completion: @escaping ObjectCompletionHandler<RatingDistribution>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(seasonNumber)/episodes/\(episodeNumber)/ratings",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Stats

    /**
     Returns lots of episode stats.
     */
    @discardableResult
    func getEpisodeStatistics<T: CustomStringConvertible>(
        showID id: T,
        seasonNumber season: NSNumber,
        episodeNumber episode: NSNumber,
        completion: @escaping statsCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/episodes/\(episode)/stats",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Watching

    /**
     Returns all users watching this episode right now.
     */
    @discardableResult
    func getUsersWatchingEpisode<T: CustomStringConvertible>(
        showID id: T,
        seasonNumber season: NSNumber,
        episodeNumber episode: NSNumber,
        completion: @escaping ObjectsCompletionHandler<User>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/episodes/\(episode)/watching",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - People

    /**
     ✨ **Extended Info**
     Returns all `cast` and `crew` for a show, including the `episode_count` for which they appears. Each `cast` member will have a `characters` array and a standard person object.
     The `crew` object will be broken up into `production`, `art`, `crew`, `costume & make-up`, `directing`, `writing`, `sound`, `camera`, `visual effects`, `lighting`, and `editing` (if there are people for those crew positions). Each of those members will have a `jobs` array and a standard `person` object.

     **Guest Stars**

     If you add `?extended=guest_stars` to the URL, it will return all guest stars that appeared in at least 1 episode of the show.

     **Note**: This returns a lot of data, so please only use this extended parameter if you actually need it!
     */
    @discardableResult
    func getPeopleInEpisode<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
        episode: NSNumber,
        extended: [ExtendedType] = [.Min],
        completion: @escaping ObjectCompletionHandler<CastAndCrew<TVCastMember, TVCrewMember>>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/episodes/\(episode)/people",
            withQuery: ["extended": extended.queryString()],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }
}
