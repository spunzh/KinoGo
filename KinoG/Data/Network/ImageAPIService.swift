// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class ImageAPIService: ImageLoadingProtocol {
    func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        guard let URL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: URL) { data, _, error in
            guard let error = error else {
                completion(.success(data))
                return
            }
            completion(.failure(error))
        }.resume()
    }
}
