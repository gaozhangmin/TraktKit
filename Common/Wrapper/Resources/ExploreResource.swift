//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct ExploreResource {

    // MARK: - Properties

    public let traktManager: TraktManager

    public lazy var trending = Trending(traktManager: traktManager)
    public lazy var popular = Popular(traktManager: traktManager)
    public lazy var recommended = Recommended(traktManager: traktManager)
    public lazy var played = Played(traktManager: traktManager)
    public lazy var watched = Watched(traktManager: traktManager)
    public lazy var collected = Collected(traktManager: traktManager)
    public lazy var anticipated = Anticipated(traktManager: traktManager)

    public init(traktManager: TraktManager = .sharedManager) {
        self.traktManager = traktManager
    }

    // MARK: - Routes

    public struct Trending {
        public let traktManager: TraktManager
        public init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        public func shows() -> Route<[TraktTrendingShow]> {
            Route(path: "shows/trending", method: .GET, traktManager: traktManager)
        }

        public func movies() -> Route<[TraktTrendingMovie]> {
            Route(path: "movies/trending", method: .GET, traktManager: traktManager)
        }
    }

    public struct Popular {
        public let traktManager: TraktManager
        public init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        public func shows() -> Route<[TraktShow]> {
            Route(path: "shows/popular", method: .GET, traktManager: traktManager)
        }

        public func movies() -> Route<[TraktMovie]> {
            Route(path: "movies/popular", method: .GET, traktManager: traktManager)
        }
    }

    public struct Recommended {
        public let traktManager: TraktManager
        public init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        public func shows() -> Route<[TraktTrendingShow]> {
            Route(path: "shows/recommended", method: .GET, traktManager: traktManager)
        }

        public func movies() -> Route<[TraktTrendingMovie]> {
            Route(path: "movies/recommended", method: .GET, traktManager: traktManager)
        }
    }

    public struct Played {
        public let traktManager: TraktManager
        public init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        public func shows() -> Route<[TraktMostShow]> {
            Route(path: "shows/played", method: .GET, traktManager: traktManager)
        }

        public func movies() -> Route<[TraktMostMovie]> {
            Route(path: "movies/played", method: .GET, traktManager: traktManager)
        }
    }

    public struct Watched {
        public let traktManager: TraktManager
        public init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        public func shows() -> Route<[TraktMostShow]> {
            Route(path: "shows/watched", method: .GET, traktManager: traktManager)
        }

        public func movies() -> Route<[TraktMostMovie]> {
            Route(path: "movies/watched", method: .GET, traktManager: traktManager)
        }
    }

    public struct Collected {
        public let traktManager: TraktManager
        public init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        public func shows() -> Route<[TraktTrendingShow]> {
            Route(path: "shows/collected", method: .GET, traktManager: traktManager)
        }

        public func movies() -> Route<[TraktTrendingMovie]> {
            Route(path: "movies/collected", method: .GET, traktManager: traktManager)
        }
    }

    public struct Anticipated {
        public let traktManager: TraktManager
        public init(traktManager: TraktManager = .sharedManager) {
            self.traktManager = traktManager
        }

        public func shows() -> Route<[TraktAnticipatedShow]> {
            Route(path: "shows/anticipated", method: .GET, traktManager: traktManager)
        }

        public func movies() -> Route<[TraktAnticipatedMovie]> {
            Route(path: "movies/anticipated", method: .GET, traktManager: traktManager)
        }
    }
}
