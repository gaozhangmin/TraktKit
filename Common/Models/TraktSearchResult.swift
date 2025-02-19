//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct TraktSearchResult: Codable, Hashable {
    public let type: String // Can be movie, show, episode, person, list
    public let score: Double?

    public let movie: TraktMovie?
    public let show: TraktShow?
    public let episode: TraktEpisode?
    public let person: Person?
    public let list: TraktList?
}
