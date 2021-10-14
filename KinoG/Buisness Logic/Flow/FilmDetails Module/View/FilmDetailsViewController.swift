// FilmDetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FilmDetailsViewController: UIViewController {
    // MARK: - Public Properties

    var viewModel: FilmDetailsViewModelProtocol?

    // MARK: - Visiual Components

    private let filmTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Private Properties

    private let identifier = "selectedFilmCell"
    private var filmViewData: FilmViewData<Film, Error> = .initial {
        didSet {
            DispatchQueue.main.async {
                self.updateViewState()
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        tableViewSetup()
        updateViewState()
        updateView()
    }

    // MARK: - Private Methods

    private func tableViewSetup() {
        view = filmTableView
        view.backgroundColor = .white

        filmTableView.dataSource = self
        filmTableView.rowHeight = UITableView.automaticDimension
        filmTableView.estimatedRowHeight = 600

        filmTableView.register(FilmDetailsTableViewCell.self, forCellReuseIdentifier: identifier)
    }

    private func updateViewState() {
        switch filmViewData {
        case .initial:
            filmTableView.isHidden = true
        case .success:
            filmTableView.isHidden = false
            filmTableView.reloadData()
        case .failure:
            filmTableView.isHidden = true
        }
    }

    private func updateView() {
        viewModel?.updateViewData = { [weak self] viewData in
            self?.filmViewData = viewData
        }
    }
}

// MARK: - SelectedFilmViewController

extension FilmDetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilmDetailsTableViewCell
        else { return UITableViewCell() }
        guard case let .success(details) = filmViewData else { return UITableViewCell() }
        cell.loadImageCompletion = viewModel?.loadImage(path:completion:)
        cell.fill(with: details)
        return cell
    }
}
