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
     Most TV shows and movies have a certification to indicate the content rating. Some API methods allow filtering by certification, so it's good to cache this list in your app.

     Note: Only `us` certifications are currently returned.
     */
    @discardableResult
    func getCertifications(completion: @escaping ObjectCompletionHandler<Certifications>) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(
            forPath: "certifications",
            withQuery: [:],
            isAuthorized: true,
            withHTTPMethod: .GET
        ) else { return nil }
        return performRequest(
            request: request,
            completion: completion
        )
    }
}
