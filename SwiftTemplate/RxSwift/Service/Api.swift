//
//  Api.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation
import RxCocoa
import RxSwift
import NSObject_Rx

class Api: ApiType {



    private let urlSession = URLSession.shared


    func fetch<T: Codable>(queryItems: [URLQueryItem]?, type: T.Type, endPoint: EndPoint) -> Observable<T?> where T: Codable {
        let request = composeUrlRequest(queryItems: queryItems, endPoint: endPoint)
        return urlSession.rx.data(request: request)
            .map {
            let decoder = JSONDecoder()
            let data = try? decoder.decode(type, from: $0)
                print("####\(data)")
            return try decoder.decode(type, from: $0)
        }
            .catchAndReturn(nil)
    }


}
