//
//  MovieDetailModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import Foundation

struct MovieDetailResult: Codable {
    let movieInfoResult: MovieInfoResult
}

// MARK: - MovieInfoResult
struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

// MARK: - MovieInfo
struct MovieInfo: Codable {
    let movieCD, movieNm, movieNmEn, movieNmOg: String
    let showTm, prdtYear, openDt, prdtStatNm: String
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
}

// MARK: - Actor
struct Actor: Codable {
    let peopleNm, peopleNmEn, cast, castEn: String
}

// MARK: - Audit
struct Audit: Codable {
    let auditNo, watchGradeNm: String
}

// MARK: - Company
struct Company: Codable {
    let companyCD, companyNm, companyNmEn, companyPartNm: String
}

// MARK: - Director
struct Director: Codable {
    let peopleNm, peopleNmEn: String
}

// MARK: - Genre
struct Genre: Codable {
    let genreNm: String
}

// MARK: - Nation
struct Nation: Codable {
    let nationNm: String
}

// MARK: - ShowType
struct ShowType: Codable {
    let showTypeGroupNm, showTypeNm: String
}
