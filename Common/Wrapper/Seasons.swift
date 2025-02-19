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
     Returns all seasons for a show including the number of episodes in each season.

     If you add `?extended=episodes` to the URL, it will return all episodes for all seasons.

     **Note**: This returns a lot of data, so please only use this method if you need it all!

     */
    @discardableResult
    func getSeasons<T: CustomStringConvertible>(
        showID id: T,
        extended: [ExtendedType] = [.Min],
        completion: @escaping SeasonsCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons",
            withQuery: ["extended": extended.queryString()],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Season

    /**
     Returns all episodes for a specific season of a show.TranslationsIf you'd like to included translated episode titles and overviews in the response, include the `translations` parameter in the URL. Include `all` languages by setting the parameter to all or use a specific 2 digit country language code to further limit it.

     **Note**: This returns a lot of data, so please only use this parameter if you actually need it!

     ✨ Extended
     */
    @discardableResult
    func getEpisodesForSeason<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
        translatedInto language: String? = nil,
        extended: [ExtendedType] = [.Min],
        completion: @escaping EpisodesCompletionHandler
    ) -> URLSessionDataTaskProtocol? {

        var query = ["extended": extended.queryString()]
        query["translations"] = language

        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)",
            withQuery: query,
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
     Returns all top level comments for a season. Most recent comments returned first.

     📄 Pagination
     */
    @discardableResult
    func getAllSeasonComments<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
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
            forPath: "shows/\(id)/seasons/\(season)/comments",
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
     Returns all lists that contain this season. By default, `personal` lists are returned sorted by the most `popular`.

     📄 Pagination
     */
    @discardableResult
    func getListsContainingSeason<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
        listType: ListType? = nil,
        sortBy: ListSortType? = nil,
        pagination: Pagination? = nil,
        completion: @escaping paginatedCompletionHandler<TraktList>
    ) -> URLSessionDataTaskProtocol? {
        var path = "shows/\(id)/seasons/\(season)/lists"
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
     Returns rating (between 0 and 10) and distribution for a season.
     */
    @discardableResult
    func getSeasonRatings<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
        completion: @escaping RatingDistributionCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/ratings",
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
     Returns lots of season stats.
     */
    @discardableResult
    func getSeasonStatistics<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
        completion: @escaping statsCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/stats",
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
     Returns all users watching this season right now.
     */
    @discardableResult
    func getUsersWatchingSeasons<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
        completion: @escaping ObjectsCompletionHandler<User>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/watching",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(request: request, completion: completion)
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
    func getPeopleInSeason<T: CustomStringConvertible>(
        showID id: T,
        season: NSNumber,
        extended: [ExtendedType] = [.Min],
        completion: @escaping ObjectCompletionHandler<CastAndCrew<TVCastMember, TVCrewMember>>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "shows/\(id)/seasons/\(season)/people",
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
