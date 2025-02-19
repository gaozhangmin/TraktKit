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
     Search by titles, descriptions, translated titles, aliases, and people. Results are ordered by the most relevant score. Specify the type of results by sending a single value or a comma delimited string for multiple types.

     Status Code: 200

     📄 Pagination
     ✨ Extended Info
     🎚 Filters
     */
    @discardableResult
    func search(
        query: String,
        types: [SearchType],
        extended: [ExtendedType] = [.Min],
        pagination: Pagination? = nil,
        filters: [Filter]? = nil,
        fields: [SearchType.Field]? = nil,
        completion: @escaping SearchCompletionHandler
    ) -> URLSessionDataTaskProtocol? {

        let typesString = types.map(\.rawValue).joined(separator: ",") // Search with multiple types
        var query: [String: String] = [
            "query": query,
            "extended": extended.queryString(),
        ]
        // pagination
        if let pagination = pagination {
            for (key, value) in pagination.value() {
                query[key] = value
            }
        }

        // Filters
        if let filters = filters {
            for (key, value) in (filters.map { $0.value() }) {
                query[key] = value
            }
        }

        // Fields
        if let fields = fields {
            query["fields"] = fields.map(\.title).joined(separator: ",")
        }

        //
        guard let request = mutableRequest(
            forPath: "search/\(typesString)",
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
     Lookup items by their Trakt, IMDB, TMDB, TVDB, or TVRage ID. If you use the search url without a `type` it might return multiple items if the `id_type` is not globally unique. Specify the `type` of results by sending a single value or a comma delimited string for multiple types.

     Status Code: 200

     📄 Pagination
     ✨ Extended Info
     */
    @discardableResult
    func lookup(
        id: LookupType,
        extended: [ExtendedType] = [.Min],
        type: SearchType,
        pagination: Pagination? = nil,
        completion: @escaping SearchCompletionHandler
    ) -> URLSessionDataTaskProtocol? {

        var query: [String: String] = [
            "extended": extended.queryString(),
            "type": type.rawValue,
        ]

        // pagination
        if let pagination = pagination {
            for (key, value) in pagination.value() {
                query[key] = value
            }
        }

        guard let request = mutableRequest(
            forPath: "search/\(id.name)/\(id.id)",
            withQuery: query,
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }
}
