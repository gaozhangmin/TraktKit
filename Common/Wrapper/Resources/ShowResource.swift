//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct ShowResource {

    // MARK: - Properties

    public let id: CustomStringConvertible
    public let traktManager: TraktManager

    // MARK: - Lifecycle

    public init(id: CustomStringConvertible, traktManager: TraktManager = .sharedManager) {
        self.id = id
        self.traktManager = traktManager
    }

    // MARK: - Methods

    public func summary() async throws -> Route<TraktShow> {
        try await traktManager.get("shows/\(id)")
    }

    public func aliases() async throws -> Route<[Alias]> {
        Route(path: "shows/\(id)/aliases", method: .GET, traktManager: traktManager)
    }

    public func certifications() async throws -> Route<Certifications> {
        Route(path: "shows/\(id)/certifications", method: .GET, traktManager: traktManager)
    }

    // MARK: - Resources

    public func season(_ number: Int) -> SeasonResource {
        SeasonResource(showId: id, seasonNumber: number, traktManager: traktManager)
    }
}
