//
//  MovieDetail.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import Foundation

struct MovieDetail {
    let movieCode: String
    let movieName: String
    let movieNameEng: String
    let movieNmOg: String
    let openDate: String
    let genreName: String
    let peopleName: String
    let actors: String
    
    init(
        movieCd: String,
        movieNm: String,
        movieNmEn: String,
        movieNmOg: String,
        openDt: String,
        genreNm: String,
        peopleNm: String,
        actors: String
    ) {
        self.movieCode = movieCd
        self.movieName = movieNm
        self.movieNameEng = movieNmEn
        self.movieNmOg = movieNmOg
        self.openDate = openDt
        self.genreName = genreNm
        self.peopleName = peopleNm
        self.actors = actors
    }
}
