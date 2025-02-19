//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

public protocol FilterType {
    func value() -> (key: String, value: String)
}

public extension TraktManager {
    /**
     Some `movies`, `shows`, `calendars`, and `search` methods support additional filters and will be tagged with 🎚 Filters. Applying these filters refines the results and helps your users to more easily discover new items.

     Add a query string (i.e. `?years=2016&genres=action`) with any filters you want to use. Some filters allow multiples which can be sent as comma delimited parameters. For example, `?genres=action,adventure` would match the `action` OR `adventure` genre.

     **Note**: Make sure to properly URL encode the parameters including spaces and special characters.
     */
    enum Filter: FilterType {
        /**
         4 digit year.
         */
        case year(year: NSNumber)
        /**
         Genre slugs.
         */
        case genres(genres: [String])
        /**
         2 character language code.
         */
        case languages(languages: [String])
        /** 2 character country code.
         */
        case countries(countries: [String])
        /**
         Range in minutes.
         */
        case runtimes(runtimes: (lower: NSNumber, upper: NSNumber))
        /**
         Range between `0` and `100`.
         */
        case ratings(ratings: (lower: NSNumber, upper: NSNumber))

        // FilterType
        public func value() -> (key: String, value: String) {
            switch self {
            case let .year(year):
                return ("years", "\(year)")
            case let .genres(genres):
                return ("genres", genres.joined(separator: ","))
            case let .languages(languages):
                return ("languages", languages.joined(separator: ","))
            case let .countries(countries):
                return ("countries", countries.joined(separator: ","))
            case let .runtimes(runtimes: (lower, upper)):
                return ("runtimes", "\(lower)-\(upper)")
            case let .ratings(ratings: (lower, upper)):
                return ("ratings", "\(lower)-\(upper)")
            }
        }
    }

    enum MovieFilter: FilterType {
        /**
         US content certification.
         */
        case certifications(certifications: [String])

        // FilterType
        public func value() -> (key: String, value: String) {
            switch self {
            case let .certifications(certifications):
                return ("genres", certifications.joined(separator: ","))
            }
        }
    }

    enum ShowFilter: FilterType {
        /**
         US content certification.
         */
        case certifications(certifications: [String])
        /**
         Network name.
         */
        case networks(networks: [String])
        /**
         Set to `returning series`, `in production`, `planned`, `canceled`, or `ended`.
         */
        case status(status: [String])

        // FilterType
        public func value() -> (key: String, value: String) {
            switch self {
            case let .certifications(certifications):
                return ("genres", certifications.joined(separator: ","))
            case let .networks(networks):
                return ("networks", networks.joined(separator: ","))
            case let .status(status):
                return ("status", status.joined(separator: ","))
            }
        }
    }
}
