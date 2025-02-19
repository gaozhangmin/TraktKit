//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct RemoveRatingsResult: Codable, Hashable {
    public let deleted: Deleted
    public let notFound: NotFound

    public struct Deleted: Codable, Hashable {
        public let movies: Int
        public let shows: Int
        public let seasons: Int
        public let episodes: Int
    }

    public struct NotFound: Codable, Hashable {
        public let movies: [NotFoundIds]
        public let shows: [NotFoundIds]
        public let seasons: [NotFoundIds]
        public let episodes: [NotFoundIds]
    }

    enum CodingKeys: String, CodingKey {
        case deleted
        case notFound = "not_found"
    }
}
