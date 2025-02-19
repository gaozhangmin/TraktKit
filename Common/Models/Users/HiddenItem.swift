//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct HiddenItem: Codable, Hashable {
    public let hiddenAt: Date
    public let type: String

    public let movie: TraktMovie?
    public let show: TraktShow?
    public let season: TraktSeason?

    enum CodingKeys: String, CodingKey {
        case hiddenAt = "hidden_at"
        case type
        case movie
        case show
        case season
    }
}
