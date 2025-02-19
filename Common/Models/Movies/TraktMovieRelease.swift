//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktMovieRelease: Codable, Hashable {
    public let country: String
    public let certification: String
    public let releaseDate: Date
    public let releaseType: ReleaseType
    public let note: String?

    enum CodingKeys: String, CodingKey {
        case country
        case certification
        case releaseDate = "release_date"
        case releaseType = "release_type"
        case note
    }

    public enum ReleaseType: String, Codable {
        case unknown
        case premiere
        case limited
        case theatrical
        case digital
        case physical
        case tv
    }
}
