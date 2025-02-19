//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public extension String {
    var description: String {
        self
    }
}

extension String {
    func toURL() -> URL? {
        guard self.isEmpty == false else { return nil }

        return URL(string: self)
    }
}
