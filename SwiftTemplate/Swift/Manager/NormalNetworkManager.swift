//
//  NormalNetworkManager.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import Foundation
import UIKit

class NormalNetworkManager {
    static let shared = NormalNetworkManager()

    func get<T: Codable>(_ url: URLRequest, type: T.Type, completion: @escaping (T) -> Void) {
        Debug.print(url.url)
        URLSession.shared.request(url, type: type) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getImage(_ url: String, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.bindImage(url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }

}
