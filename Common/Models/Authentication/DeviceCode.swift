//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

#if canImport(UIKit)
import UIKit
#endif

public struct DeviceCode: Codable {
    public let deviceCode: String
    public let userCode: String
    public let verificationURL: String
    public let expiresIn: Int
    public let interval: Int

    #if canImport(UIKit)
    #if canImport(CoreImage)
    public func getQRCode() -> UIImage? {
        let data = self.verificationURL.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    #endif
    #endif

    enum CodingKeys: String, CodingKey {
        case deviceCode = "device_code"
        case userCode = "user_code"
        case verificationURL = "verification_url"
        case expiresIn = "expires_in"
        case interval
    }
}
