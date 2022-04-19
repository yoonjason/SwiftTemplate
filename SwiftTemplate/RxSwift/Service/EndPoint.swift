//
//  EndPoint.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation

let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"

func composeUrlRequest(date: String) -> URLRequest {
    let urlString = "\(movieURL)&key=\(apiKey)&targetDt=\(date)"
    let url = URL(string: urlString)!
    return URLRequest(url: url)
}
