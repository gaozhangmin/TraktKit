//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

// Actor/Actress/Crew member
public struct Person: Codable, Hashable {
    // Extended: Min
    public let name: String
    public let ids: ID

    // Extended: Full
    public let biography: String?
    public let birthday: Date?
    public let death: Date?
    public let birthplace: String?
    public let homepage: URL?

    enum CodingKeys: String, CodingKey {
        case name
        case ids

        case biography
        case birthday
        case death
        case birthplace
        case homepage
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        ids = try container.decode(ID.self, forKey: CodingKeys.ids)
        biography = try container.decodeIfPresent(String.self, forKey: CodingKeys.biography)
        birthday = try container.decodeIfPresent(Date.self, forKey: CodingKeys.birthday)
        death = try container.decodeIfPresent(Date.self, forKey: CodingKeys.death)
        birthplace = try container.decodeIfPresent(String.self, forKey: CodingKeys.birthplace)
        do {
            homepage = try container.decodeIfPresent(URL.self, forKey: CodingKeys.homepage)
        } catch {
            homepage = nil
        }
    }
}
