// FilmTypeTableViewCell.swift
// Copyright © Spunzh. All rights reserved.

import UIKit

//
enum FilmType: String {
    case popular
    case upcoming
    case topRated = "top_rated"
}

final class FilmTypeTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let filmsSegmetedControll: UISegmentedControl = {
        let items = ["Popular", "Top Rated", "Upcoming"]
        let segmentControll = UISegmentedControl(items: items)
        segmentControll.selectedSegmentIndex = 0
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        return segmentControll
    }()

    // MARK: - Public Properties

    var didSelect: ((FilmType) -> Void)?

    // MARK: - Private Methods

    override func setSelected(_: Bool, animated _: Bool) {
        filmsSegmetedControll.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }

    override func layoutSubviews() {
        contentView.addSubview(filmsSegmetedControll)
        filmsSegmetedControllConstraintSetup()
    }

    @objc private func segmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            didSelect?(.popular)
        case 1:
            didSelect?(.topRated)
        case 2:
            didSelect?(.upcoming)
        default:
            print("error")
        }
    }

    private func filmsSegmetedControllConstraintSetup() {
        NSLayoutConstraint.activate([
            filmsSegmetedControll.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            filmsSegmetedControll.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmsSegmetedControll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
