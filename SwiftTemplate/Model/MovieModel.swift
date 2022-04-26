//
//  Movie.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieCd: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}
