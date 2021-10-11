// SelectedFilmTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SelectedFilmTableViewCell: UITableViewCell {
    private let filmImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        return image
    }()
    
    private var filmNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var filmDiscriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var filmDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Private Properties
    
    private let imageCatalogAdress = "https://image.tmdb.org/t/p/w500/"
    
    // MARK: - Public Methods
    
    public func fill(with film: Results) {
        filmDateLabel.text = film.releaseDate
        filmDiscriptionLabel.text = film.overview
        filmNameLabel.text = film.title
    }
    
    public func setPicture(type: Results) {
        let adress = "\(imageCatalogAdress)\(type.posterPath)"
        guard let URL = URL(string: adress) else { return }
        DispatchQueue.main.async {
            guard let data = try? Data(contentsOf: URL) else { return }
            self.filmImageView.image = UIImage(data: data)
        }
    }
    
    // MARK: - Private Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        contentView.addSubview(filmImageView)
        contentView.addSubview(filmNameLabel)
        contentView.addSubview(filmDiscriptionLabel)
        contentView.addSubview(filmDateLabel)
        
        filmImageViewConstraintSetup()
        filmDiscriptionConstraintSetup()
        filmNameLabelConstraintSetup()
        filmDateLabelConstraintSetup()
    }
    
    private func filmImageViewConstraintSetup() {
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            filmImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            filmImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            filmImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func filmNameLabelConstraintSetup() {
        NSLayoutConstraint.activate([
            filmNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            filmNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            filmNameLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 20)
        ])
    }
    
    private func filmDiscriptionConstraintSetup() {
        NSLayoutConstraint.activate([
            filmDiscriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            filmDiscriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            filmDiscriptionLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 10),
        ])
    }
    
    private func filmDateLabelConstraintSetup() {
        NSLayoutConstraint.activate([
            filmDateLabel.topAnchor.constraint(equalTo: filmDiscriptionLabel.bottomAnchor, constant: 20),
            filmDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            filmDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
}
