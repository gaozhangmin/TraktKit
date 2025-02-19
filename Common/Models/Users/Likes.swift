//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct Like: Codable, Hashable {
    public let likedAt: Date
    public let type: LikeType
    public let list: TraktList?
    public let comment: Comment?

    public enum LikeType: String, Codable {
        case comment
        case list
    }

    enum CodingKeys: String, CodingKey {
        case likedAt = "liked_at"
        case type
        case list
        case comment
    }
}
