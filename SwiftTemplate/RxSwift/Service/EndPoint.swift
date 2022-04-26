//
//  EndPoint.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation

let movieURL = "boxoffice/searchDailyBoxOfficeList.json?"
let BaseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/"

enum EndPoint: String {
    case dailyMovieListURL = "boxoffice/searchDailyBoxOfficeList.json?"
    case movieList = "movie/searchMovieList.json?"
    case weekMovieListURL = "boxoffice/searchWeeklyBoxOfficeList.json?"
    case movieDetailInfoURL = "movie/searchMovieInfo.json?"
}

func composeUrlRequest(queryItems: [URLQueryItem]?, endPoint: EndPoint) -> URLRequest {
    var baseQueryItem = [
        URLQueryItem(name: "key", value: apiKey)
    ]
    if let queryItems = queryItems {
        baseQueryItem.append(contentsOf: queryItems)
    }
    var urlComps = URLComponents(string: "\(BaseURL)\(endPoint.rawValue)")
    urlComps?.queryItems = baseQueryItem
    let url = (urlComps?.url)!
    return URLRequest(url: url)
}
