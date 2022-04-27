//
//  EndPoint.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation

let BaseURL = "https://api.unsplash.com/"

enum EndPoint: String {
    case getPhoto = "photos?"
    case searchPhoto = "search/photos?"
}

func composeUrlRequest(queryItems: [URLQueryItem]?, endPoint: EndPoint) -> URLRequest {
    var baseQueryItem = [
        URLQueryItem(name: "client_id", value: apiKey)
    ]
    if let queryItems = queryItems {
        baseQueryItem.append(contentsOf: queryItems)
    }
    var urlComps = URLComponents(string: "\(BaseURL)\(endPoint.rawValue)")
    urlComps?.queryItems = baseQueryItem
    let url = (urlComps?.url)!
    return URLRequest(url: url)
}
