//
//  Network.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import Foundation

enum HttpMethod<T> {
    case get
    case post(T)
    case put(T)
    case patch(T)
    case delete(T)
}

//235. 4.5y
//ph327kw1 210 us3

extension URLRequest {
    init<T: Codable> (url: URL, method: HttpMethod<T>) {
        self.init(url: url)
        self.timeoutInterval = TimeInterval(10)
        switch method {
        case .get:
            self.httpMethod = "GET"
        case .post(let body):
            self.httpMethod = "POST"
            self.httpBody = try? JSONEncoder().encode(body.self)
        case .delete(let body):
            self.httpMethod = "DELETE"
            self.httpBody = try? JSONEncoder().encode(body.self)
        case .put(let body):
            self.httpMethod = "PUT"
            self.httpBody = try? JSONEncoder().encode(body.self)
        case .patch(let body):
            self.httpMethod = "PATCH"
            self.httpBody = try? JSONEncoder().encode(body.self)
        }
    }
}

enum NetworkError: Error {
    case someError
    case dataError
}

extension URLSession {
    func request<T: Codable>(_ url: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.someError))
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            guard let result = try? JSONDecoder().decode(type, from: data) else {
                return
            }
            completion(.success(result))
        }
        .resume()
    }
}
