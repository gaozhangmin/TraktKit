//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension TraktManager {

    /**
     Returns all shows airing during the time period specified.

     🔒 OAuth: Required

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func myShows(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarShow>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/my/shows/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all new show premieres (season 1, episode 1) airing during the time period specified.

     🔒 OAuth: Required

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func myNewShows(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarShow>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/my/shows/new/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all show premieres (any season, episode 1) airing during the time period specified.

     🔒 OAuth: Required

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func mySeasonPremieres(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarShow>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/my/shows/premieres/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all movies with a release date during the time period specified.

     🔒 OAuth: Required

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func myMovies(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarMovie>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/my/movies/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all movies with a DVD release date during the time period specified.

     🔒 OAuth: Required
     ✨ Extended Info
     🎚 Filters
     */
    @discardableResult
    func myDVDReleases(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarMovie>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/my/dvd/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all shows airing during the time period specified.

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func allShows(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarShow>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/all/shows/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all new show premieres (season 1, episode 1) airing during the time period specified.

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func allNewShows(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarShow>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/all/shows/new/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all show premieres (any season, episode 1) airing during the time period specified.

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func allSeasonPremieres(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarShow>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/all/shows/premieres/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns all movies with a release date during the time period specified.

     - parameter startDateString: Start the calendar on this date. E.X. `2014-09-01`
     - parameter days: Number of days to display. Example: `7`.
     */
    @discardableResult
    func allMovies(
        startDateString dateString: String,
        days: Int,
        extended: [ExtendedType] = [.Min],
        filters: [Filter]? = nil,
        completion: @escaping ObjectsCompletionHandler<CalendarMovie>
    ) -> URLSessionDataTaskProtocol? {

        var query: [String: String] = ["extended": extended.queryString()]

        // Filters
        if let filters = filters {
            for (key, value) in (filters.map { $0.value() }) {
                query[key] = value
            }
        }

        guard let request = mutableRequest(
            forPath: "calendars/all/movies/\(dateString)/\(days)",
            withQuery: query,
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     */
    @discardableResult
    func allDVD(
        startDateString dateString: String,
        days: Int,
        completion: @escaping ObjectsCompletionHandler<CalendarMovie>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "calendars/all/dvd/\(dateString)/\(days)",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }
}
