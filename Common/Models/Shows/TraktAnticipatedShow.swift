//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktAnticipatedShow: Codable, Hashable {

    // Extended: Min
    public let listCount: Int
    public let show: TraktShow

    enum CodingKeys: String, CodingKey {
        case listCount = "list_count"
        case show
    }
}
