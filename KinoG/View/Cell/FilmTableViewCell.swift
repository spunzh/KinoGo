// FilmTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FilmTableViewCell: UITableViewCell {
    // MARK: - Visiual Components
    
    private let filmImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        return image
    }()
    
    private var filmNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var filmDiscriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var filmDateLabel: UILabel = {
        let label = UILabel()
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
            filmImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            filmImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            filmImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.41),
            filmImageView.heightAnchor.constraint(equalTo: filmImageView.widthAnchor, multiplier: 1.5)
        ])
    }
    
    private func filmNameLabelConstraintSetup() {
        NSLayoutConstraint.activate([
            filmNameLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10),
            filmNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            filmNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
    
    private func filmDiscriptionConstraintSetup() {
        NSLayoutConstraint.activate([
            filmDiscriptionLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10),
            filmDiscriptionLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 10),
            filmDiscriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            filmDiscriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func filmDateLabelConstraintSetup() {
        NSLayoutConstraint.activate([
            filmDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            filmDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
