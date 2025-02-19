//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct FollowRequest: Codable, Hashable {
    public let id: Int
    public let requestedAt: Date
    public let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case requestedAt = "requested_at"
        case user
    }
}

public struct FollowResult: Codable, Hashable {
    public let followedAt: Date
    public let user: User

    enum CodingKeys: String, CodingKey {
        case followedAt = "followed_at"
        case user
    }
}
