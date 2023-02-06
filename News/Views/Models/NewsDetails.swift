//
//  NewsDetails.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.
//

import Foundation

// MARK: - NewsDetails
struct NewsDetails: Codable {
    let title, publishedAt: String
    let description, urlToImage, url: String?
    let source: Source
//    let viewsCount: Int
}

struct Source: Codable {
    let name: String
}
