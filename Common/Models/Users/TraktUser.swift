//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct User: Codable, Hashable {

    // Min
    public let username: String?
    public let isPrivate: Bool
    public let name: String?
    public let isVIP: Bool?
    public let isVIPEP: Bool?
    public let ids: IDs

    // Full
    public let joinedAt: Date?
    public let location: String?
    public let about: String?
    public let gender: String?
    public let age: Int?
    public let images: Images?

    // VIP
    public let vipOG: Bool?
    public let vipYears: Int?

    enum CodingKeys: String, CodingKey {
        case username
        case isPrivate = "private"
        case name
        case isVIP = "vip"
        case isVIPEP = "vip_ep"
        case ids
        case joinedAt = "joined_at"
        case location
        case about
        case gender
        case age
        case images
        case vipOG = "vip_og"
        case vipYears = "vip_years"
    }

    public struct IDs: Codable, Hashable {
        public let slug: String
    }

    public struct Images: Codable, Hashable {
        public let avatar: Image
    }

    public struct Image: Codable, Hashable {
        public let full: String
    }
}
