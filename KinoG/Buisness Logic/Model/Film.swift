// Film.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Film
struct Film: Decodable {
    let results: [Results]
}

// Result
struct Results: Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String
}
