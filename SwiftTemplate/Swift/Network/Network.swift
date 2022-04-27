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

enum NetworkError: Error {
    case someError
    case dataError
    case decodeError
}




