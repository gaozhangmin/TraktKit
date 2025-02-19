//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktWatching: Codable, Hashable {
    public let expiresAt: Date
    public let startedAt: Date
    public let action: String
    public let type: String

    public let episode: TraktEpisode?
    public let show: TraktShow?
    public let movie: TraktMovie?

    enum CodingKeys: String, CodingKey {
        case expiresAt = "expires_at"
        case startedAt = "started_at"
        case action
        case type

        case episode
        case show
        case movie
    }
}
