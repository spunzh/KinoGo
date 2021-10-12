// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    func getFilms(type: Int, complition: @escaping (Result<[Film], Error>) -> Void)
    func getFilmDetails(filmID: Int, complition: @escaping (Result<Film, Error>) -> Void)
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Public Methods

    func getFilms(type: Int, complition: @escaping (Result<[Film], Error>) -> Void) {
        let adress = urlSetup(type: type)
        guard let url = URL(string: adress) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jdata = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let film = try decoder.decode(Objects.self, from: jdata)
                let details = film.results
                complition(.success(details))
            } catch {
                print("Error serialization json", error)
            }
        }
        dataTask.resume()
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

private func urlSetup(type: Int) -> String {
    switch type {
    case 0:
        return "https://api.themoviedb.org/3/movie/popular?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US&page=1"
    case 1:
        return "https://api.themoviedb.org/3/movie/top_rated?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US&page=1"
    case 2:
        return "https://api.themoviedb.org/3/movie/upcoming?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US&page=1"
    default:
        return ""
    }
}
