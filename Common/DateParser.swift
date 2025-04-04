//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

// Internal
let calendar = Calendar.current
let dateFormatter = DateFormatter()

@Sendable
public func customDateDecodingStrategy(decoder: Decoder) throws -> Date {
    let container = try decoder.singleValueContainer()
    let str = try container.decode(String.self)
    return try Date.dateFromString(str)
}

extension Date {

    enum DateParserError: Error {
        case failedToParseDateFromString(String)
        case typeUnhandled(Any?)
    }

    // MARK: - Class

    static func dateFromString(_ string: Any?) throws -> Date {
        if let dateString = string as? String {

            let count = dateString.count
            if count <= 10 {
                ISO8601DateFormatter.dateFormat = "yyyy-MM-dd"
            } else if count == 23 {
                ISO8601DateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            } else {
                ISO8601DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            }

            if let date = ISO8601DateFormatter.date(from: dateString) {
                return date
            } else {
                throw DateParserError
                    .failedToParseDateFromString(
                        "String to parse: \(dateString), date format: \(String(describing: ISO8601DateFormatter.dateFormat))"
                    )
            }
        } else if let date = string as? Date {
            return date
        } else {
            throw DateParserError.typeUnhandled(string)
        }
    }

    func UTCDateString() -> String {
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let UTCString = self.dateString(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        dateFormatter.timeZone = TimeZone.current
        return UTCString
    }

    func dateString(withFormat format: String) -> String {
        ISO8601DateFormatter.dateFormat = format
        return ISO8601DateFormatter.string(from: self)
    }
}

// Private

private let ISO8601DateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
    dateFormatter.locale = enUSPOSIXLocale
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") ?? TimeZone.current
    return dateFormatter
}()
