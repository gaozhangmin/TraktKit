//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public enum ListPrivacy: String, Codable {
    case `private`
    case friends
    case `public`
}

public struct TraktList: Codable, Hashable {
    public let allowComments: Bool
    public let commentCount: Int
    public let createdAt: Date?
    public let description: String?
    public let displayNumbers: Bool
    public var itemCount: Int
    public var likes: Int
    public let name: String
    public let privacy: ListPrivacy
    public let updatedAt: Date
    public let ids: ListId

    enum CodingKeys: String, CodingKey {
        case allowComments = "allow_comments"
        case commentCount = "comment_count"
        case createdAt = "created_at"
        case description
        case displayNumbers = "display_numbers"
        case itemCount = "item_count"
        case likes
        case name
        case privacy
        case updatedAt = "updated_at"
        case ids
    }
}

public struct TraktTrendingList: Codable, Hashable {
    public let likeCount: Int
    public let commentCount: Int
    public let list: TraktList

    enum CodingKeys: String, CodingKey {
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case list
    }
}
