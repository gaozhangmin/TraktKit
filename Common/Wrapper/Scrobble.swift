//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension TraktManager {

    // MARK: - Start

    /**
     Use this method when the video intially starts playing or is unpaused. This will remove any playback progress if it exists.

     **Note**: A watching status will auto expire after the remaining runtime has elpased. There is no need to re-send every 15 minutes.

     🔒 OAuth: Required
     */
    @discardableResult
    func scrobbleStart(
        _ scrobble: TraktScrobble,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        try perform("start", scrobble: scrobble, completion: completion)
    }

    @discardableResult
    func scrobbleStart(
        _ scrobble: TraktScrobbleWithEpisodeNum,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        try perform("start", scrobble: scrobble, completion: completion)
    }

    // MARK: - Pause

    /**
     Use this method when the video is paused. The playback progress will be saved and **GET** `/sync/playback` can be used to resume the video from this exact position. Unpause a video by calling the **GET** `/scrobble/start` method again.

     🔒 OAuth: Required
     */
    @discardableResult
    func scrobblePause(
        _ scrobble: TraktScrobble,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        try perform("pause", scrobble: scrobble, completion: completion)
    }

    @discardableResult
    func scrobblePause(
        _ scrobble: TraktScrobbleWithEpisodeNum,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        try perform("pause", scrobble: scrobble, completion: completion)
    }

    // MARK: - Stop

    /**
     Use this method when the video is stopped or finishes playing on its own. If the progress is above 80%, the video will be scrobbled and the action will be set to **scrobble**.

     If the progress is less than 80%, it will be treated as a pause and the `action` will be set to `pause`. The playback progress will be saved and **GET** `/sync/playback` can be used to resume the video from this exact position.

     **Note**: If you prefer to use a threshold higher than 80%, you should use **GET** `/scrobble/pause` yourself so it doesn't create duplicate scrobbles.

     🔒 OAuth: Required
     */
    @discardableResult
    func scrobbleStop(
        _ scrobble: TraktScrobble,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        try perform("stop", scrobble: scrobble, completion: completion)
    }

    @discardableResult
    func scrobbleStop(
        _ scrobble: TraktScrobbleWithEpisodeNum,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        try perform("stop", scrobble: scrobble, completion: completion)
    }

    // MARK: - Private

    @discardableResult
    internal func perform(
        _ scrobbleAction: String,
        scrobble: TraktScrobble,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        // Request
        guard let request = post("scrobble/\(scrobbleAction)", body: scrobble) else { return nil }
        return performRequest(request: request, completion: completion)
    }

    @discardableResult
    internal func perform(
        _ scrobbleAction: String,
        scrobble: TraktScrobbleWithEpisodeNum,
        completion: @escaping ObjectCompletionHandler<ScrobbleResult>
    ) throws -> URLSessionDataTaskProtocol? {
        // Request
        guard let request = post("scrobble/\(scrobbleAction)", body: scrobble) else { return nil }
        return performRequest(request: request, completion: completion)
    }
}
