//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension TraktManager {

    // MARK: - Public

    /**
     Personalized movie recommendations for a user. Results returned with the top recommendation first. By default, `10` results are returned. You can send a limit to get up to `100` results per page.

     🔒 OAuth: Required
     ✨ Extended Info
     */
    @discardableResult
    func getRecommendedMovies(completion: @escaping ObjectsCompletionHandler<TraktMovie>) -> URLSessionDataTaskProtocol? {
        getRecommendations(.Movies, completion: completion)
    }

    /**
     Hide a movie from getting recommended anymore.

     🔒 OAuth: Required
     */
    @discardableResult
    func hideRecommendedMovie<T: CustomStringConvertible>(
        movieID id: T,
        completion: @escaping SuccessCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        hideRecommendation(type: .Movies, id: id, completion: completion)
    }

    /**
     Personalized show recommendations for a user. Results returned with the top recommendation first.

     🔒 OAuth: Required
     */
    @discardableResult
    func getRecommendedShows(completion: @escaping ObjectsCompletionHandler<TraktShow>) -> URLSessionDataTaskProtocol? {
        getRecommendations(.Shows, completion: completion)
    }

    /**
     Hide a show from getting recommended anymore.

     🔒 OAuth: Required
     */
    @discardableResult
    func hideRecommendedShow<T: CustomStringConvertible>(
        showID id: T,
        completion: @escaping SuccessCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        hideRecommendation(type: .Shows, id: id, completion: completion)
    }

    // MARK: - Private

    @discardableResult
    private func getRecommendations<T>(
        _ type: WatchedType,
        completion: @escaping ObjectsCompletionHandler<T>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "recommendations/\(type)",
            withQuery: [:],
            isAuthorized: true,
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

    @discardableResult
    private func hideRecommendation<T: CustomStringConvertible>(
        type: WatchedType,
        id: T,
        completion: @escaping SuccessCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "recommendations/\(type)/\(id)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .DELETE
        ) else {
            completion(.fail)
            return nil
        }
        return performRequest(
            request: request,
            completion: completion
        )
    }
}
