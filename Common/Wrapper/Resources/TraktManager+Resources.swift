//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension TraktManager {

    func show(id: CustomStringConvertible) -> ShowResource {
        ShowResource(id: id, traktManager: self)
    }

    func season(showId: CustomStringConvertible, season: Int) -> SeasonResource {
        SeasonResource(showId: showId, seasonNumber: season, traktManager: self)
    }

    func episode(showId: CustomStringConvertible, season: Int, episode: Int) -> EpisodeResource {
        EpisodeResource(showId: showId, seasonNumber: season, episodeNumber: episode, traktManager: self)
    }

    func currentUser() -> CurrentUserResource {
        CurrentUserResource()
    }

    func user(_ username: String) -> UsersResource {
        UsersResource(username: username, traktManager: self)
    }

    func search() -> SearchResource {
        SearchResource(traktManager: self)
    }
}
