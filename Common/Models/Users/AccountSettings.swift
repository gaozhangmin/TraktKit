//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public struct AccountSettings: Codable, Hashable {
    public let user: User
    public let connections: Connections

    public struct Connections: Codable, Hashable {
        public let facebook: Bool
        public let twitter: Bool
        public let google: Bool
        public let tumblr: Bool
        public let medium: Bool
        public let slack: Bool
    }
}
