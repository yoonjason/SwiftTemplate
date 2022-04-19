//
//  NetworkManager.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/18.
//

import Foundation
import RxCocoa
import RxSwift

enum MyError {
    case urlError
    
}

class NetworkManager {
    static let shared = NetworkManager()

    let urlSession = URLSession.shared

    func test<T:Codable>() -> Observable<T?> {
        let url = URL(string: "")
        let request = URLRequest(url: URL(string: "")!)
        return urlSession.rx.data(request: request)
            .map {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: $0)
        }
            .catchAndReturn(nil)
    }
    
    func requestDownload(_ url: URL) -> Observable<UIImage> {
        return Observable.create { emit in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    return }
                guard let image = UIImage(data: data!) else {
                    return }
                emit.onNext(image)
                emit.onCompleted()
            }
            .resume()
            return Disposables.create()
        }
    }
    
   


}
