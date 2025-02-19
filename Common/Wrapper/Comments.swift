//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension TraktManager {

    // MARK: - Comments

    /**
     Add a new comment to a movie, show, season, episode, or list. Make sure to allow and encourage spoilers to be indicated in your app and follow the rules listed above.

     🔒 OAuth: Required
     */
    @discardableResult
    func postComment(
        movie: SyncTmdbId? = nil,
        show: SyncTmdbId? = nil,
        season: SyncTmdbId? = nil,
        episode: SyncTmdbId? = nil,
        list: SyncTmdbId? = nil,
        comment: String,
        isSpoiler spoiler: Bool? = nil,
        completion: @escaping SuccessCompletionHandler
    ) throws -> URLSessionDataTaskProtocol? {
        let body = TraktCommentBody(
            movie: movie,
            show: show,
            season: season,
            episode: episode,
            list: list,
            comment: comment,
            spoiler: spoiler
        )
        guard let request = post("comments", body: body) else { return nil }
        return performRequest(request: request, completion: completion)
    }

    /**
     Returns a single comment and indicates how many replies it has. Use **GET** `/comments/:id/replies` to get the actual replies.
     */
    @discardableResult
    func getComment<T: CustomStringConvertible>(
        commentID id: T,
        completion: @escaping ObjectCompletionHandler<Comment>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/\(id)",
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
     Update a single comment created within the last hour. The OAuth user must match the author of the comment in order to update it.

     🔒 OAuth: Required
     */
    @discardableResult
    func updateComment<T: CustomStringConvertible>(
        commentID id: T,
        newComment comment: String,
        isSpoiler spoiler: Bool? = nil,
        completion: @escaping ObjectCompletionHandler<Comment>
    ) throws -> URLSessionDataTaskProtocol? {
        let body = TraktCommentBody(comment: comment, spoiler: spoiler)
        guard var request = mutableRequest(
            forPath: "comments/\(id)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .PUT
        ) else { return nil }
        request.httpBody = try jsonEncoder.encode(body)
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Delete a single comment created within the last hour. This also effectively removes any replies this comment has. The OAuth user must match the author of the comment in order to delete it.

     🔒 OAuth: Required
     */
    @discardableResult
    func deleteComment<T: CustomStringConvertible>(
        commentID id: T,
        completion: @escaping SuccessCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/\(id)",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .DELETE
        ) else { return nil }
        return performRequest(request: request, completion: completion)
    }

    // MARK: - Replies

    /**
     Returns all replies for a comment. It is possible these replies could have replies themselves, so in that case you would just call **GET** `/comments/:id/replies` again with the new comment `id`.

     📄 Pagination
     */
    @discardableResult
    func getReplies<T: CustomStringConvertible>(
        commentID id: T,
        completion: @escaping ObjectsCompletionHandler<Comment>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/\(id)/replies",
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
     Add a new reply to an existing comment. Make sure to allow and encourage spoilers to be indicated in your app and follow the rules listed above.

     🔒 OAuth: Required
     */
    @discardableResult
    func postReply<T: CustomStringConvertible>(
        commentID id: T,
        comment: String,
        isSpoiler spoiler: Bool? = nil,
        completion: @escaping ObjectCompletionHandler<Comment>
    ) throws -> URLSessionDataTaskProtocol? {
        let body = TraktCommentBody(comment: comment, spoiler: spoiler)
        guard let request = post("comments/\(id)/replies", body: body) else { return nil }
        return performRequest(request: request, completion: completion)
    }

    // MARK: - Item

    /**
     Returns all users who liked a comment. If you only need the `replies` count, the main `comment` object already has that, so no need to use this method.

     📄 Pagination
     */
    @discardableResult
    func getAttachedMediaItem<T: CustomStringConvertible>(
        commentID id: T,
        completion: @escaping ObjectCompletionHandler<TraktAttachedMediaItem>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/\(id)/item",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .POST
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Likes

    /**
     Returns the media item this comment is attached to. The media type can be `movie`, `show`, `season`, `episode`, or `list` and it also returns the standard media object for that media type.

     ✨ Extended Info
     */
    @discardableResult
    func getUsersWhoLikedComment<T: CustomStringConvertible>(
        commentID id: T,
        completion: @escaping ObjectsCompletionHandler<TraktCommentLikedUser>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/\(id)/likes",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Like

    /**
     Votes help determine popular comments. Only one like is allowed per comment per user.

     🔒 OAuth: Required
     */
    @discardableResult
    func likeComment<T: CustomStringConvertible>(
        commentID id: T,
        completion: @escaping SuccessCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/\(id)/like",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .POST
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    /**
     Remove a like on a comment.

     🔒 OAuth: Required
     */
    @discardableResult
    func removeLikeOnComment<T: CustomStringConvertible>(
        commentID id: T,
        completion: @escaping SuccessCompletionHandler
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/\(id)/like",
            withQuery: [:],
            isAuthorized: false,
            withHTTPMethod: .DELETE
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Trending

    /**
     Returns all comments with the most likes and replies over the last 7 days. You can optionally filter by the `comment_type` and media `type` to limit what gets returned. If you want to `include_replies` that will return replies in place alongside top level comments.

     📄 Pagination
     ✨ Extended
     */
    @discardableResult
    func getTrendingComments(
        commentType: CommentType,
        mediaType: Type2,
        includeReplies: Bool,
        completion: @escaping ObjectsCompletionHandler<TraktTrendingComment>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/trending/\(commentType.rawValue)/\(mediaType.rawValue)",
            withQuery: ["include_replies": "\(includeReplies)"],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Recent

    /**
     Returns the most recently written comments across all of Trakt. You can optionally filter by the `comment_type` and media `type` to limit what gets returned. If you want to `include_replies` that will return replies in place alongside top level comments.

     📄 Pagination
     ✨ Extended
     */
    @discardableResult
    func getRecentComments(
        commentType: CommentType,
        mediaType: Type2,
        includeReplies: Bool,
        completion: @escaping ObjectsCompletionHandler<TraktTrendingComment>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/recent/\(commentType.rawValue)/\(mediaType.rawValue)",
            withQuery: ["include_replies": "\(includeReplies)"],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }

    // MARK: - Updates

    /**
     Returns the most recently updated comments across all of Trakt. You can optionally filter by the `comment_type` and media `type` to limit what gets returned. If you want to `include_replies` that will return replies in place alongside top level comments.

     📄 Pagination
     ✨ Extended
     */
    @discardableResult
    func getRecentlyUpdatedComments(
        commentType: CommentType,
        mediaType: Type2,
        includeReplies: Bool,
        completion: @escaping ObjectsCompletionHandler<TraktTrendingComment>
    ) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "comments/updates/\(commentType.rawValue)/\(mediaType.rawValue)",
            withQuery: ["include_replies": "\(includeReplies)"],
            isAuthorized: false,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }
}
