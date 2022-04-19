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
    
    
    func fetch<T>(date: String, type: T.Type) -> Observable<T?> where T : Codable {
        let request = composeUrlRequest(date: date)
        return urlSession.rx.data(request: request)
            .map {
                let decoder = JSONDecoder()
                return try decoder.decode(type, from: $0)
            }
            .catchAndReturn(nil)
    }
    
    
}
