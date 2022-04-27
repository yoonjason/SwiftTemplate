

import Foundation

extension URLRequest {
    init<T: Codable> (url: URL, method: HttpMethod<T>) {
        self.init(url: url)
        self.timeoutInterval = TimeInterval(10)
        switch method {
        case .get:
            self.httpMethod = "GET"
        case .post(let body):
            self.httpMethod = "POST"
            self.httpBody = try? JSONEncoder().encode(body.self)
        case .delete(let body):
            self.httpMethod = "DELETE"
            self.httpBody = try? JSONEncoder().encode(body.self)
        case .put(let body):
            self.httpMethod = "PUT"
            self.httpBody = try? JSONEncoder().encode(body.self)
        case .patch(let body):
            self.httpMethod = "PATCH"
            self.httpBody = try? JSONEncoder().encode(body.self)
        }
    }
}
