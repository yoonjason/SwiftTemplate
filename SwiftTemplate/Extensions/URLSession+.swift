import Foundation
import UIKit

extension URLSession {
    func request<T: Codable>(_ url: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.someError))
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            print(data)
            guard let result = try? JSONDecoder().decode(type, from: data) else {
                completion(.failure(.decodeError))
                return
            }
            completion(.success(result))
        }
            .resume()
    }
    
    func bindImage(_ url: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void ) {
        let cacheKey = NSString(string: url)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            completion(.success(cachedImage))
        }
        let request = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.someError))
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(.decodeError))
                return
            }
            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            completion(.success(image))
        }
        .resume()
    }
}
