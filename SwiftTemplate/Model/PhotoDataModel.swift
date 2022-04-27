import Foundation

struct PhotoData: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoModel]
}

struct PhotoModel: Codable, Equatable {
    let id: String
    let urls: Urls
    let likes: Int
    
    static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, small_s3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case small_s3
    }
}

