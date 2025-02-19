//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct CalendarShow: Codable, Hashable {
    public let firstAired: Date
    public let episode: TraktEpisode
    public let show: TraktShow

    enum CodingKeys: String, CodingKey {
        case firstAired = "first_aired"
        case episode
        case show
    }
}
