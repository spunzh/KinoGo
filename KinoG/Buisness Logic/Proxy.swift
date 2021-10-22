// Proxy.swift
// Copyright © RoadMap. All rights reserved.

//
//  Proxy.swift
//  KinoG
//
//  Created by Мажит Закиров on 18.10.2021.
//
import Foundation

protocol ImageLoadingProtocol {
    func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> ())
}

final class ImageProxy: ImageLoadingProtocol {
    private let imageAPIService: ImageLoadingProtocol
    private let imageCacheService: ImageCacheServiceProtocol

    init(APIservice: ImageLoadingProtocol, cacheService: ImageCacheService) {
        imageAPIService = APIservice
        imageCacheService = cacheService
    }

    func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        let imageCatalogAdress = "https://image.tmdb.org/t/p/w500/\(url)"

        if let imageData = imageCacheService.getImage(url: imageCatalogAdress) {
            completion(.success(imageData))
        } else {
            imageAPIService.loadImage(url: imageCatalogAdress) { [weak self] result in
                switch result {
                case let .success(data):
                    self?.imageCacheService.saveImage(url: imageCatalogAdress, image: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
