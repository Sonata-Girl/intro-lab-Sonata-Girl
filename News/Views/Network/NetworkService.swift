//
//  NetworkService.swift
//  News
//
//  Created by Sonata Girl on 05.02.2023.
//

import Foundation

final class NetworkService {

    static var shared = NetworkService()

    private init() {}

    enum RequestType: String {
        case recepts = "complexSearch"
        case detailed = "/information"
    }

    private let baseURL: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6af59f0f9cc241db9956aa76d5e0f55e")

    private let key = "?apiKey=6af59f0f9cc241db9956aa76d5e0f55e"

    public func getTopNews(complerion: @escaping (Result<[String], Error>) -> Void) {
//        guard let url = baseURL
    }
}
