//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct Update: Codable, Hashable {
    public let updatedAt: Date
    public let movie: TraktMovie?
    public let show: TraktShow?

    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case movie
        case show
    }
}
