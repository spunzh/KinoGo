// SelectedFilmViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SelectedFilmViewController: UIViewController {
    // MARK: - Visiual Components
    
    private let filmTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Public Properties
    
    public var filmID: Results?
    
    // MARK: - Private Properties
    
    private let model = FilmRequest()
    private let identifier = "selectedFilmCell"
    private var details: Results? {
        didSet {
            DispatchQueue.main.async {
                self.filmTableView.reloadData()
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view = filmTableView
        view.backgroundColor = .white
        
        tableViewSetup()
        setDetails(filmID: filmID)
    }
    
    // MARK: - Private Methods
    
    private func setDetails(filmID: Results?) {
        guard let id = filmID?.id else { return }
        model.getFilmDetails(filmID: id) { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(details):
                self?.details = details
            }
        }
    }
    
    private func tableViewSetup() {
        filmTableView.dataSource = self
        filmTableView.rowHeight = UITableView.automaticDimension
        filmTableView.estimatedRowHeight = 190
        
        filmTableView.register(SelectedFilmTableViewCell.self, forCellReuseIdentifier: identifier)
    }
}

// MARK: - SelectedFilmViewController

extension SelectedFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SelectedFilmTableViewCell
        else { return UITableViewCell() }
        if let filmDetails = details {
            cell.fill(with: filmDetails)
            cell.setPicture(type: filmDetails)
        }
        return cell
    }
}
