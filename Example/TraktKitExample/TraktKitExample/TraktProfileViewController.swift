//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import TraktKit
import UIKit

final class TraktProfileViewController: UIViewController {

    // MARK: - Properties

    private let stackView = UIStackView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        TraktManager.sharedManager.getUserProfile { [weak self] result in
            switch result {
            case let .success(user):
                DispatchQueue.main.async { [weak self] in
                    self?.refreshUI(for: user)
                }
            case let .error(error):
                print("Failed to get user profile: \(String(describing: error?.localizedDescription))")
            }
        }
    }

    // MARK: - Actions

    private func refreshUI(for user: User) {
        func createLabel(title: String) -> UILabel {
            let label = UILabel()
            label.text = title
            label.numberOfLines = 0
            return label
        }
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stackView.addArrangedSubview(createLabel(title: "Name: \(user.name ?? "Unknown")"))
        stackView.addArrangedSubview(createLabel(title: "Username: \(user.username ?? "Unknown")"))
        stackView.addArrangedSubview(createLabel(title: "Profile is private: \(user.isPrivate)"))
        stackView.addArrangedSubview(createLabel(title: "is VIP: \(user.isVIP ?? false)"))
        stackView.addArrangedSubview(createLabel(title: "About: \(user.about ?? "Unknown")"))
    }

    // MARK: Setup

    private func setup() {
        self.title = "Profile"
        view.backgroundColor = .white

        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let label = UILabel()
        label.text = "Loading..."
        stackView.addArrangedSubview(label)
    }
}
