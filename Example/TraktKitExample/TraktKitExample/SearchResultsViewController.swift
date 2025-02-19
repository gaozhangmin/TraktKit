//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import TraktKit
import UIKit

final class SearchResultsViewController: UITableViewController {

    // MARK: - Properties

    private var shows: [TraktShow] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    let query: String

    // MARK: - Lifecycle

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError()
    }

    init(query: String) {
        self.query = query
        super.init(style: .plain)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        TraktManager.sharedManager
            .search(query: query, types: [.show], extended: [.Full], pagination: nil, filters: nil, fields: nil) { [weak self] result in
                switch result {
                case let .success(objects):
                    DispatchQueue.main.async {
                        self?.shows = objects.compactMap(\.show)
                    }
                case let .error(error):
                    print("Failed to get search results: \(String(describing: error?.localizedDescription))")
                }
            }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let show = shows[indexPath.row]
        cell.textLabel?.text = show.title
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        func dataOrUnknown(_ input: String?) -> String {
            input ?? "Unknown"
        }

        func numberOrUnknown(_ input: Int?) -> String {
            input != nil ? "\(input!)" : "Unknown"
        }

        let show = shows[indexPath.row]
        let showInfo = """
        Show name: \(show.title),
        Year: \(numberOrUnknown(show.year)),
        Certification: \(dataOrUnknown(show.certification)),
        Country: \(dataOrUnknown(show.country)),
        Day of week airing: \(dataOrUnknown(show.airs?.day)),
        """

        let alertController = UIAlertController(title: "Info", message: showInfo, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
