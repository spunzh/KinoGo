// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ImageAPIServiceProtocol {
    func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> ())
}

final class ImageAPIService: ImageAPIServiceProtocol {
    private let imageAdress = "https://image.tmdb.org/t/p/w500"

    func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        let fullAdress = imageAdress + url
        guard let URL = URL(string: fullAdress) else { return }
        URLSession.shared.dataTask(with: URL) { data, _, error in
            guard let error = error else {
                completion(.success(data))
                return
            }
            completion(.failure(error))
        }.resume()
    }
}
