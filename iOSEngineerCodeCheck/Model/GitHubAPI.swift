//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 田中大誓 on 2023/01/28.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

class GitHubAPI {
    private static var task: URLSessionTask?

    enum FetchRepositoryError: Error {
        case wrong
        case network
        case parse
    }

    static func fetchRepository(text: String, completionHandler: @escaping (Result<[Repository], FetchRepositoryError>) -> Void) {
        if !text.isEmpty {

            let urlString = "https://api.github.com/search/repositories?q=\(text)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(FetchRepositoryError.wrong))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
                if err != nil {
                    completionHandler(.failure(FetchRepositoryError.network))
                    return
                }

                guard let safeData = data else {return}

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decodedData = try decoder.decode(Repositories.self, from: safeData)
                    completionHandler(.success(decodedData.items))

                } catch  {
                    completionHandler(.failure(FetchRepositoryError.parse))
                }
            }
            task.resume()
        }
    }

    static func taskCancel() {
        task?.cancel()
    }
}
