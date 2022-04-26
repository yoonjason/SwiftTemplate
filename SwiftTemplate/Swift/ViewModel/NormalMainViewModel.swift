//
//  NormalMainViewModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import Foundation


class NormalMainViewModel {

    func fetchDailyMovies(_ completion: @escaping ([Movie]) -> Void) {
        var movie = [Movie]()
        let queryItems = [
            URLQueryItem(name: "targetDt", value: "20220424")
        ]
        let request = composeUrlRequest(queryItems: queryItems, endPoint: EndPoint.dailyMovieListURL)
        URLSession.shared.request(request, type: MovieData.self) { (result) in
            switch result {
            case .success(let movieData):
                print("성공?")
                movie = movieData.boxOfficeResult.dailyBoxOfficeList.map {
                    Movie(movieNm: $0.movieNm, rank: $0.rank, openDate: $0.openDt, audiCnt: $0.audiCnt, accAudi: $0.audiAcc, movieCd: $0.movieCd)
                }
                completion(movie)
            case .failure(let error):
                print(error)
            }
        }
    }


}
