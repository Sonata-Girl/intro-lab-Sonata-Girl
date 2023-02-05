//
//  NetworkService.swift
//  News
//
//  Created by Sonata Girl on 05.02.2023.
//

//import Foundation
//
//final class APIRequest {
//
//    static let shared = APIRequest()
//
//    private init() {}
//
//    private let baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6af59f0f9cc241db9956aa76d5e0f55e")
//
//    private let key = "?apiKey=6af59f0f9cc241db9956aa76d5e0f55e"
//
//    public func getTopNews(completion: @escaping (Result<[String], Error>) -> Void) {
//        guard let url = baseURL else {
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                completion(.failure(error))
//            }
//            else if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(String.self, from: data)
//                }
//                catch {
//                    completion(.failure(error))
//                }
//            }
//        }
//        task.resume()
//    }
//}
//
//struct APIResponce: Codable {
//    let articles: [Article]
//}
