//
//  NormalNetworkManager.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import Foundation
import UIKit

protocol Provider {
    func get<T: Codable>(_ url: URLRequest, type: T.Type, completion: @escaping (T) -> Void)
    func getImage(_ url: String, completion: @escaping (UIImage) -> Void)
}

class NormalNetworkManager: Provider {
    static let shared = NormalNetworkManager()
    let urlSession = URLSession.shared
    func get<T: Codable>(_ url: URLRequest, type: T.Type, completion: @escaping (T) -> Void) {
        Debug.print(url.url)
        urlSession.request(url, type: type) { (result) in
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
    
    func getImage(_ url: String) -> UIImage? {
        var resultImage = UIImage()
        urlSession.bindImage(url) { result in
            switch result {
            case .success(let image):
                resultImage = image
            case .failure(let error):
                print(error)
            }
        }
        return resultImage
    }

}
