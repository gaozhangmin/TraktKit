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
     Returns all lists with the most likes and comments over the last 7 days.

     📄 Pagination
     */
    @discardableResult
    func getTrendingLists(completion: @escaping ObjectsCompletionHandler<TraktTrendingList>) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "lists/trending",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else {
            completion(.error(error: nil))
            return nil
        }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Returns the most popular lists. Popularity is calculated using total number of likes and comments.

     📄 Pagination
     */
    @discardableResult
    func getPopularLists(completion: @escaping ObjectsCompletionHandler<TraktTrendingList>) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "lists/popular",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else {
            completion(.error(error: nil))
            return nil
        }
        return performRequest(
            request: request,
            completion: completion
        )
    }
}
