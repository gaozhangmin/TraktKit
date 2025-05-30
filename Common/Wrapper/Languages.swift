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
     Get a list of all genres, including names and slugs.
     */
    @discardableResult
    func listLanguages(type: WatchedType, completion: @escaping ObjectsCompletionHandler<Languages>) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "languages/\(type)",
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
