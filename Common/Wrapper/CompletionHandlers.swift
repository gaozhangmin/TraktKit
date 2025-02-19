//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

/// Generic result type
public enum ObjectResultType<T: Codable> {
    case success(object: T)
    case error(error: Error?)
}

/// Generic results type
public enum ObjectsResultType<T: Codable> {
    case success(objects: [T])
    case error(error: Error?)
}

/// Generic results type + Pagination
public enum ObjectsResultTypePagination<T: Codable> {
    case success(objects: [T], currentPage: Int, limit: Int)
    case error(error: Error?)
}

public extension TraktManager {

    // MARK: - Result Types

    enum DataResultType {
        case success(data: Data)
        case error(error: Error?)
    }

    enum SuccessResultType {
        case success
        case fail
    }

    enum ProgressResultType {
        case success
        case fail(Int)
    }

    enum WatchingResultType {
        case checkedIn(watching: TraktWatching)
        case notCheckedIn
        case error(error: Error?)
    }

    enum CheckinResultType {
        case success(checkin: TraktCheckinResponse)
        case checkedIn(expiration: Date)
        case error(error: Error?)
    }

    enum TraktKitError: Error {
        case couldNotParseData
        case handlingRetry
    }

    enum TraktError: Error {
        /// Bad Request - request couldn't be parsed
        case badRequest
        /// Oauth must be provided
        case unauthorized
        /// Forbidden - invalid API key or unapproved app
        case forbidden
        /// Not Found - method exists, but no record found
        case noRecordFound
        /// Method Not Found - method doesn't exist
        case noMethodFound
        /// Conflict - resource already created
        case resourceAlreadyCreated
        /// Account Limit Exceeded - list count, item count, etc
        case accountLimitExceeded
        /// Locked User Account - have the user contact support
        case accountLocked
        /// VIP Only - user must upgrade to VIP
        case vipOnly
        /// Rate Limit Exceeded
        case rateLimitExceeded(HTTPURLResponse)
        /// Service Unavailable - server overloaded (try again in 30s)
        case serverOverloaded
        /// Service Unavailable - Cloudflare error
        case cloudflareError
        /// Full url response
        case unhandled(HTTPURLResponse)
    }

    // MARK: - Completion handlers

    // MARK: Common

    typealias ObjectCompletionHandler<T: Codable> = (_ result: ObjectResultType<T>) -> Void
    typealias ObjectsCompletionHandler<T: Codable> = (_ result: ObjectsResultType<T>) -> Void
    typealias paginatedCompletionHandler<T: Codable> = (_ result: ObjectsResultTypePagination<T>) -> Void

    typealias DataResultCompletionHandler = (_ result: DataResultType) -> Void
    typealias SuccessCompletionHandler = (_ result: SuccessResultType) -> Void
    typealias ProgressCompletionHandler = (_ result: ProgressResultType) -> Void
    typealias CommentsCompletionHandler = paginatedCompletionHandler<Comment>
//    public typealias CastCrewCompletionHandler = ObjectCompletionHandler<CastAndCrew>

    typealias SearchCompletionHandler = ObjectsCompletionHandler<TraktSearchResult>
    typealias statsCompletionHandler = ObjectCompletionHandler<TraktStats>

    // MARK: Shared

    typealias UpdateCompletionHandler = paginatedCompletionHandler<Update>
    typealias AliasCompletionHandler = ObjectsCompletionHandler<Alias>
    typealias RatingDistributionCompletionHandler = ObjectCompletionHandler<RatingDistribution>

    // MARK: Calendar

    typealias dvdReleaseCompletionHandler = ObjectsCompletionHandler<TraktDVDReleaseMovie>

    // MARK: Checkin

    typealias checkinCompletionHandler = (_ result: CheckinResultType) -> Void

    // MARK: Shows

    typealias TrendingShowsCompletionHandler = paginatedCompletionHandler<TraktTrendingShow>
    typealias MostShowsCompletionHandler = paginatedCompletionHandler<TraktMostShow>
    typealias AnticipatedShowCompletionHandler = paginatedCompletionHandler<TraktAnticipatedShow>
    typealias ShowTranslationsCompletionHandler = ObjectsCompletionHandler<TraktShowTranslation>
    typealias SeasonsCompletionHandler = ObjectsCompletionHandler<TraktSeason>

    typealias WatchedShowsCompletionHandler = ObjectsCompletionHandler<TraktWatchedShow>
    typealias ShowWatchedProgressCompletionHandler = ObjectCompletionHandler<TraktShowWatchedProgress>

    // MARK: Episodes

    typealias EpisodeCompletionHandler = ObjectCompletionHandler<TraktEpisode>
    typealias EpisodesCompletionHandler = ObjectsCompletionHandler<TraktEpisode>

    // MARK: Movies

    typealias MovieCompletionHandler = ObjectCompletionHandler<TraktMovie>
    typealias MoviesCompletionHandler = ObjectsCompletionHandler<TraktMovie>
    typealias TrendingMoviesCompletionHandler = paginatedCompletionHandler<TraktTrendingMovie>
    typealias MostMoviesCompletionHandler = paginatedCompletionHandler<TraktMostMovie>
    typealias AnticipatedMovieCompletionHandler = paginatedCompletionHandler<TraktAnticipatedMovie>
    typealias MovieTranslationsCompletionHandler = ObjectsCompletionHandler<TraktMovieTranslation>
    typealias WatchedMoviesCompletionHandler = paginatedCompletionHandler<TraktWatchedMovie>
    typealias BoxOfficeMoviesCompletionHandler = ObjectsCompletionHandler<TraktBoxOfficeMovie>

    // MARK: Sync

    typealias LastActivitiesCompletionHandler = ObjectCompletionHandler<TraktLastActivities>
    typealias RatingsCompletionHandler = ObjectsCompletionHandler<TraktRating>
    typealias HistoryCompletionHandler = paginatedCompletionHandler<TraktHistoryItem>
    typealias CollectionCompletionHandler = ObjectsCompletionHandler<TraktCollectedItem>

    // MARK: Users

    typealias ListCompletionHandler = ObjectCompletionHandler<TraktList>
    typealias ListsCompletionHandler = ObjectsCompletionHandler<TraktList>
    typealias ListItemCompletionHandler = ObjectsCompletionHandler<TraktListItem>
    typealias WatchlistCompletionHandler = paginatedCompletionHandler<TraktListItem>
    typealias HiddenItemsCompletionHandler = paginatedCompletionHandler<HiddenItem>
    typealias UserCommentsCompletionHandler = ObjectsCompletionHandler<UsersComments>
    typealias AddListItemCompletion = ObjectCompletionHandler<ListItemPostResult>
    typealias RemoveListItemCompletion = ObjectCompletionHandler<RemoveListItemResult>
    typealias FollowUserCompletion = ObjectCompletionHandler<FollowUserResult>
    typealias FollowersCompletion = ObjectsCompletionHandler<FollowResult>
    typealias FriendsCompletion = ObjectsCompletionHandler<Friend>
    typealias WatchingCompletion = (_ result: WatchingResultType) -> Void
    typealias UserStatsCompletion = ObjectCompletionHandler<UserStats>
    typealias UserWatchedCompletion = ObjectsCompletionHandler<TraktWatchedItem>

    // MARK: - Error handling

    private func handleResponse(response: URLResponse?, retry: @escaping (() -> Void)) throws {
        guard let httpResponse = response as? HTTPURLResponse else { throw TraktKitError.couldNotParseData }

        guard 200 ... 299 ~= httpResponse.statusCode else {
            switch httpResponse.statusCode {
            case StatusCodes.BadRequest:
                throw TraktError.badRequest
            case StatusCodes.Unauthorized:
                throw TraktError.unauthorized
            case StatusCodes.Forbidden:
                throw TraktError.forbidden
            case StatusCodes.NotFound:
                throw TraktError.noRecordFound
            case StatusCodes.MethodNotFound:
                throw TraktError.noMethodFound
            case StatusCodes.Conflict:
                throw TraktError.resourceAlreadyCreated
            case StatusCodes.AccountLimitExceeded:
                throw TraktError.accountLimitExceeded
            case StatusCodes.acountLocked:
                throw TraktError.accountLocked
            case StatusCodes.vipOnly:
                throw TraktError.vipOnly
            case StatusCodes.RateLimitExceeded:
                if let retryAfter = httpResponse.allHeaderFields["retry-after"] as? String,
                   let retryInterval = TimeInterval(retryAfter)
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + retryInterval) {
                        retry()
                    }
                    /// To ensure completionHandler isn't called when retrying.
                    throw TraktKitError.handlingRetry
                } else {
                    throw TraktError.rateLimitExceeded(httpResponse)
                }
            case 503, 504:
                throw TraktError.serverOverloaded
            case 500 ... 600:
                throw TraktError.cloudflareError
            default:
                throw TraktError.unhandled(httpResponse)
            }
        }
    }

    // MARK: - Perform Requests

    internal func perform<T: Codable>(request: URLRequest) async throws -> T {
        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)
        let object = try decoder.decode(T.self, from: data)
        return object
    }

    /// Data
    internal func performRequest(request: URLRequest, completion: @escaping DataResultCompletionHandler) -> URLSessionDataTaskProtocol? {
        let datatask = session._dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(.error(error: error))
                return
            }

            // Check response
            do {
                try self.handleResponse(response: response, retry: {
                    _ = self.performRequest(request: request, completion: completion)
                })
            } catch {
                switch error {
                case TraktKitError.handlingRetry:
                    break
                default:
                    completion(.error(error: error))
                }
                return
            }

            // Check data
            guard let data = data else {
                completion(.error(error: TraktKitError.couldNotParseData))
                return
            }
            completion(.success(data: data))
        }
        datatask.resume()
        return datatask
    }

    /// Success / Failure
    internal func performRequest(request: URLRequest, completion: @escaping SuccessCompletionHandler) -> URLSessionDataTaskProtocol? {
        let datatask = session._dataTask(with: request) { [weak self] _, response, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(.fail)
                return
            }

            // Check response
            do {
                try self.handleResponse(response: response, retry: {
                    _ = self.performRequest(request: request, completion: completion)
                })
            } catch {
                switch error {
                case TraktKitError.handlingRetry:
                    break
                default:
                    completion(.fail)
                }
                return
            }

            completion(.success)
        }
        datatask.resume()
        return datatask
    }

    /// Checkin
    internal func performRequest(request: URLRequest, completion: @escaping checkinCompletionHandler) -> URLSessionDataTaskProtocol? {
        let datatask = session._dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(.error(error: error))
                return
            }

            // Check data
            guard let data = data else {
                completion(.error(error: TraktKitError.couldNotParseData))
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)

            if let checkin = try? decoder.decode(TraktCheckinResponse.self, from: data) {
                completion(.success(checkin: checkin))
                return
            } else if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                      let jsonDictionary = jsonObject as? RawJSON,
                      let expirationDateString = jsonDictionary["expires_at"] as? String,
                      let expirationDate = try? Date.dateFromString(expirationDateString)
            {
                completion(.checkedIn(expiration: expirationDate))
                return
            }

            // Check response
            do {
                try self.handleResponse(response: response, retry: {
                    _ = self.performRequest(request: request, completion: completion)
                })
            } catch {
                switch error {
                case TraktKitError.handlingRetry:
                    break
                default:
                    completion(.error(error: error))
                }
                return
            }

            completion(.error(error: nil))
        }
        datatask.resume()
        return datatask
    }

    // Generic array of Trakt objects
    internal func performRequest<T>(
        request: URLRequest,
        completion: @escaping ((_ result: ObjectResultType<T>) -> Void)
    ) -> URLSessionDataTaskProtocol? {
        let aCompletion: DataResultCompletionHandler = { result in
            switch result {
            case let .success(data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)
                do {
                    let object = try decoder.decode(T.self, from: data)
                    completion(.success(object: object))
                } catch {
                    completion(.error(error: error))
                }
            case let .error(error):
                completion(.error(error: error))
            }
        }

        let dataTask = performRequest(request: request, completion: aCompletion)
        return dataTask
    }

    /// Array of TraktProtocol objects
    internal func performRequest<T: Decodable>(
        request: URLRequest,
        completion: @escaping ((_ result: ObjectsResultType<T>) -> Void)
    ) -> URLSessionDataTaskProtocol? {
        let dataTask = session._dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(.error(error: error))
                return
            }

            // Check response
            do {
                try self.handleResponse(response: response, retry: {
                    _ = self.performRequest(request: request, completion: completion)
                })
            } catch {
                switch error {
                case TraktKitError.handlingRetry:
                    break
                default:
                    completion(.error(error: error))
                }
                return
            }

            // Check data
            guard let data = data else {
                completion(.error(error: TraktKitError.couldNotParseData))
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)
            do {
                let array = try decoder.decode([T].self, from: data)
                completion(.success(objects: array))
            } catch {
                completion(.error(error: error))
            }
        }

        dataTask.resume()
        return dataTask
    }

    /// Array of ObjectsResultTypePagination objects
    internal func performRequest<T>(
        request: URLRequest,
        completion: @escaping ((_ result: ObjectsResultTypePagination<T>) -> Void)
    ) -> URLSessionDataTaskProtocol? {
        let dataTask = session._dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(.error(error: error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else { return completion(.error(error: nil)) }

            // Check response
            do {
                try self.handleResponse(response: response, retry: {
                    _ = self.performRequest(request: request, completion: completion)
                })
            } catch {
                switch error {
                case TraktKitError.handlingRetry:
                    break
                default:
                    completion(.error(error: error))
                }
                return
            }

            var pageCount: Int = 0
            if let pCount = httpResponse.allHeaderFields["x-pagination-page-count"] as? String,
               let pCountInt = Int(pCount)
            {
                pageCount = pCountInt
            }

            var currentPage: Int = 0
            if let cPage = httpResponse.allHeaderFields["x-pagination-page"] as? String,
               let cPageInt = Int(cPage)
            {
                currentPage = cPageInt
            }

            // Check data
            guard let data = data else {
                completion(.error(error: TraktKitError.couldNotParseData))
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)
            do {
                let array = try decoder.decode([T].self, from: data)
                completion(.success(objects: array, currentPage: currentPage, limit: pageCount))
            } catch {
                completion(.error(error: error))
            }
        }

        dataTask.resume()
        return dataTask
    }

    // Watching
    internal func performRequest(request: URLRequest, completion: @escaping WatchingCompletion) -> URLSessionDataTaskProtocol? {
        let dataTask = session._dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(.error(error: error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else { return completion(.error(error: nil)) }

            // Check response
            do {
                try self.handleResponse(response: response, retry: {
                    _ = self.performRequest(request: request, completion: completion)
                })
            } catch {
                switch error {
                case TraktKitError.handlingRetry:
                    break
                default:
                    completion(.error(error: error))
                }
                return
            }

            if httpResponse.statusCode == StatusCodes.SuccessNoContentToReturn {
                completion(.notCheckedIn)
                return
            }

            // Check data
            guard let data = data else {
                completion(.error(error: TraktKitError.couldNotParseData))
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)
            do {
                let watching = try decoder.decode(TraktWatching.self, from: data)
                completion(.checkedIn(watching: watching))
            } catch {
                completion(.error(error: error))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
