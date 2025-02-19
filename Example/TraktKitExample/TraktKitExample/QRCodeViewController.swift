//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import TraktKit
import UIKit

final class QRCodeViewController: UIViewController {
    var data: DeviceCode?

    private let codeLabel: UILabel = UILabel()
    private let qrImageView: UIImageView = UIImageView()

    public func set(_ data: DeviceCode) {
        self.codeLabel.text = data.user_code
        self.qrImageView.image = data.getQRCode()
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.qrImageView.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
        self.codeLabel.frame = CGRect(x: 0, y: 400, width: 300, height: 100)

        self.view.addSubview(self.qrImageView)
        self.view.addSubview(self.codeLabel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.start()
    }

    private func start() {
        TraktManager.sharedManager.getTokenFromDevice(code: self.data) { result in
            switch result {
            case let .fail(progress):
                print(progress)
                if progress == 0 {
                    self.dismisOnMainThread()
                }
            case .success:
                self.dismisOnMainThread()
            }
        }
    }

    private func dismisOnMainThread() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
