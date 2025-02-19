//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct ScrobbleResult: Codable, Hashable {
    public let id: Int
    public let action: String
    public let progress: Float
    public let movie: TraktMovie?
    public let episode: TraktEpisode?
    public let show: TraktShow?
}
