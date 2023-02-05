//
//  NewsDetails.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.
//

import Foundation

// MARK: - NewsDetails
struct NewsDetails: Decodable {
    let title, imageName, description, Date, link, SourceName: String
    let viewsCount: Int
}
