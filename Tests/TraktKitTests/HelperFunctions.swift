//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation
@testable import TraktKit
import XCTest

func debugPrintError(_ error: Error) {
    switch error {
    case let DecodingError.keyNotFound(key, _):
        print("Key not found: \(key)")
    case let DecodingError.typeMismatch(type, context):
        print("Type mismatch: \(type), \(context)")
    case let DecodingError.valueNotFound(value, _):
        print("Value not found: \(value)")
    case let DecodingError.dataCorrupted(context):
        print("Data corrupted: \(context)")
    default:
        break
    }
}

func jsonData(named: String) -> Data {
    let bundle = Bundle.forClass(MovieTests.self, forTests: true)
    let path = bundle.path(forResource: named, ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
    return data
}

extension XCTestCase {
    @discardableResult
    func decode<T: Decodable>(_ fileName: String, to type: T.Type = T.self) -> T? {
        let data = jsonData(named: fileName)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrintError(error)
            XCTFail("Failed to parse \(T.self)")
        }
        return nil
    }
}

extension Bundle {
    static func forClass(_ bundleClass: AnyClass, forTests: Bool = false) -> Bundle {
        #if SWIFT_PACKAGE
        if forTests {
            return Bundle.testingBundle
        } else {
            return Bundle.modulebundle
        }
        #else
        return Bundle(for: bundleClass)
        #endif
    }

    private static var testingBundle = packageBundle(for: "TraktKit_TraktKitTests")
    private static var modulebundle = packageBundle()

    /// Searches all bundles for the correct one since Swift Package bundles don't work.
    /// - Parameter bundleName: "packageName_ProductName"
    private static func packageBundle(for bundleName: String = "TraktKit_TraktKit") -> Bundle {
        // Sometimes the bundle is in here
        if let bundle = Bundle.allBundles.filter({ $0.bundleURL.lastPathComponent.contains(bundleName) }).first {
            return bundle
        }

        // Sometimes the bundle isn't in there because of reasons, so we can try to find it in the xctest bundle.
        if let bundlePath = Bundle.allBundles
            .filter({ $0.bundleURL.pathExtension == "xctest" })
            .first?
            .path(forResource: bundleName, ofType: "bundle"),
            let bundle = Bundle(path: bundlePath)
        {
            return bundle
        }

        // The bundle will be found here if running tests of the Swift package itself.
        // This has to come last because it will fatalError rather than return nil.
        return Bundle.module
    }
}
