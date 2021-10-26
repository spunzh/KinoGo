// ImageCacheService.swift
// Copyright © Spunzh. All rights reserved.

import Foundation

import UIKit

protocol ImageCacheServiceProtocol {
    func saveImage(url: String, image: Data?)
    func getImage(url: String) -> Data?
}

final class ImageCacheService: ImageCacheServiceProtocol {
    // MARK: - Private Properties

    private var pathName: String! {
        let pathName = "images"

        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }

        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }

        return pathName
    }

    // MARK: - Public Properties

    func saveImage(url: String, image: Data?) {
        guard let fileName = getFilePath(url: url) else { return }
        FileManager.default.createFile(atPath: fileName, contents: image)
    }

    func getImage(url: String) -> Data? {
        guard let fileName = getFilePath(url: url) else { return nil }
        return UIImage(contentsOfFile: fileName)?.pngData()
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }

        let hashName = url.split(separator: "/").last ?? " "
        return cachesDirectory.appendingPathComponent(pathName + "/" + hashName).path
    }
}
