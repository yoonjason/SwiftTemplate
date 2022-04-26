//
//  Movie.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import Foundation

struct Movie {
    static var movieId: Int = 0   // 아이디가 하나씩 부여되도록 만듦
    let movieName: String
    let rank: Int
    let openDate: String
    let todayAudience: Int
    let totalAudience: Int
    let movieCode: String
    
    init(movieNm: String, rank: String, openDate: String, audiCnt: String, accAudi: String, movieCd: String) {
        self.movieCode = movieCd
        self.movieName = movieNm
        self.rank = Int(rank)!
        self.openDate = openDate
        self.todayAudience = Int(audiCnt)!
        self.totalAudience = Int(accAudi)!
        Movie.movieId += 1
    }
    
}
