//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct RatingDistribution: Codable, Hashable {
    public let rating: Double
    public let votes: Int
    public let distribution: Distribution

    public struct Distribution: Codable, Hashable {
        public let one: Int
        public let two: Int
        public let three: Int
        public let four: Int
        public let five: Int
        public let six: Int
        public let seven: Int
        public let eight: Int
        public let nine: Int
        public let ten: Int

        enum CodingKeys: String, CodingKey {
            case one = "1"
            case two = "2"
            case three = "3"
            case four = "4"
            case five = "5"
            case six = "6"
            case seven = "7"
            case eight = "8"
            case nine = "9"
            case ten = "10"
        }
    }
}
