// FilmsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FilmsViewController: UIViewController {
    enum CellTypes {
        case filmType
        case films
    }

    enum CellIdentifiers: String {
        case filmCell
        case filmTypeCell
    }

    // MARK: - Visiual Components

    private let filmTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Public Properties

    var viewModel: FilmViewModelProtocol?

    // MARK: - Private Properties

    private let cellTypes: [CellTypes] = [.filmType, .films]
    private var filmViewData: FilmViewData?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        tableViewSetup()
        viewModel?.getFilms(type: 0)
        updateView()
    }

    // MARK: - Private Methods

    private func tableViewSetup() {
        view = filmTableView
        view.backgroundColor = .white

        filmTableView.dataSource = self
        filmTableView.delegate = self
        filmTableView.rowHeight = UITableView.automaticDimension
        filmTableView.estimatedRowHeight = 190

        filmTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.filmCell.rawValue)
        filmTableView.register(
            FilmTypeTableViewCell.self,
            forCellReuseIdentifier: CellIdentifiers.filmTypeCell.rawValue
        )
    }

    private func updateView() {
        viewModel?.updateViewData = { [weak self] viewData in
            switch viewData {
            case .success: break
            case .reload:
                DispatchQueue.main.async {
                    self?.filmTableView.reloadData()
                }
            case let .failure(error):
                // TODO: - Добавить Алерт с ошибкой
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension FilmsViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        cellTypes.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let types = cellTypes[section]
        switch types {
        case .filmType:
            return 1
        case .films:
            return viewModel?.films.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let types = cellTypes[indexPath.section]
        switch types {
        case .filmType:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: CellIdentifiers.filmTypeCell
                        .rawValue
                ) as? FilmTypeTableViewCell
            else { return UITableViewCell() }

            cell.didSelect = { [weak self] type in
                switch type {
                case .popular:
                    self?.viewModel?.getFilms(type: 0)
                case .topRated:
                    self?.viewModel?.getFilms(type: 1)
                case .upcoming:
                    self?.viewModel?.getFilms(type: 2)
                }
            }
            return cell

        case .films:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: CellIdentifiers.filmCell.rawValue) as? FilmTableViewCell
            else { return UITableViewCell() }
            guard let viewModel = viewModel else { return UITableViewCell() }
            cell.fill(with: viewModel.films[indexPath.row])
            cell.setPicture(type: viewModel.films[indexPath.row])
            return cell
        }
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt _: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }
}

// MARK: - UITableViewDelegate

extension FilmsViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {}
}
