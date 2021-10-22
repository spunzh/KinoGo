// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol MovieAPIServiceProtocol {
    func getFilms(type: FilmType, complition: @escaping (Result<[Film], Error>) -> Void)
    func getFilmDetails(filmID: Int, complition: @escaping (Result<Film, Error>) -> Void)
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Public Methods

    func getFilms(type: FilmType, complition: @escaping (Result<[Film], Error>) -> Void) {
        let adress = urlSetup(type: type)
        guard let url = URL(string: adress) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let film = try decoder.decode(Objects.self, from: data)
                film.results.forEach { $0.type = type.rawValue }

                let details = film.results
                complition(.success(details))
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
    }

    func getFilmDetails(filmID: Int, complition: @escaping (Result<Film, Error>) -> Void) {
        let adress =
            "https://api.themoviedb.org/3/movie/\(filmID)?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US"
        guard let url = URL(string: adress) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jdata = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode(Film.self, from: jdata)
                complition(.success(results))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}

// MARK: - Private Method

private func urlSetup(type: FilmType) -> String {
    switch type {
    case .popular:
        return "https://api.themoviedb.org/3/movie/popular?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US&page=1"
    case .topRated:
        return "https://api.themoviedb.org/3/movie/top_rated?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US&page=1"
    case .upcoming:
        return "https://api.themoviedb.org/3/movie/upcoming?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US&page=1"
    }
}
