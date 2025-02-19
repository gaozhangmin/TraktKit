//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

/// Cast member for (show/season/episode)/people API
public struct TVCrewMember: Codable, Hashable {
    public let jobs: [String]
    @available(*, deprecated, renamed: "jobs")
    public let job: String
    /// Not available for /episodes/{number}/people
    public let episodeCount: Int?
    public let person: Person

    enum CodingKeys: String, CodingKey {
        case jobs
        case job
        case episodeCount = "episode_count"
        case person
    }
}

/// Cast member for /movies/.../people API
public struct MovieCrewMember: Codable, Hashable {
    public let jobs: [String]
    @available(*, deprecated, renamed: "jobs")
    public let job: String
    public let person: Person

    enum CodingKeys: String, CodingKey {
        case jobs
        case job
        case person
    }
}

/// Cast member for /people/.../shows API
public struct PeopleTVCrewMember: Codable, Hashable {
    public let jobs: [String]
    @available(*, deprecated, renamed: "jobs")
    public let job: String
    public let episodeCount: Int
    public let show: TraktShow

    enum CodingKeys: String, CodingKey {
        case jobs
        case job
        case episodeCount = "episode_count"
        case show
    }
}

/// Cast member for /people/.../movies API
public struct PeopleMovieCrewMember: Codable, Hashable {
    public let jobs: [String]
    @available(*, deprecated, renamed: "jobs")
    public let job: String
    public let movie: TraktMovie

    enum CodingKeys: String, CodingKey {
        case jobs
        case job
        case movie
    }
}
