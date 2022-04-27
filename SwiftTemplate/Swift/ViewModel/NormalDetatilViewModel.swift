//
//  NormalDetatilViewModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import Foundation


class NormalDetatilViewModel {

    func fetchMovieDetail(_ movideCode: String, _ completion: @escaping (MovieDetail) -> Void) {
        let queryItem = [URLQueryItem(name: "movieCd", value: movideCode)]
        let request = composeUrlRequest(queryItems: queryItem, endPoint: EndPoint.getPhoto)
        print(request.url)
        NormalNetworkManager.shared.get(request, type: MovieDetailResult.self) { result in
            
//            let result = $0.movieInfo
//            completion(MovieDetail(
//                movieCd: result.movieCd, movieNm: result.movieNm,
//                movieNmEn: result.movieNmEn, movieNmOg: result.movieNmOg,
//                openDt: result.movieNmOg, genreNm: result.genreNm,
//                peopleNm: result.peopleNm, actors: result.actors
//            ))
        }
    }

}
