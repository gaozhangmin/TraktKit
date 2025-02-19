//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktMostMovie: Codable, Hashable {

    // Extended: Min
    public let watcherCount: Int
    public let playCount: Int
    public let collectedCount: Int
    public let movie: TraktMovie

    enum CodingKeys: String, CodingKey {
        case watcherCount = "watcher_count"
        case playCount = "play_count"
        case collectedCount = "collected_count"
        case movie
    }
}
