//
//  Photo.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import Foundation
import UIKit

struct Photo: Hashable {
    var image: UIImage? = nil
    let photoURL: String
    let likes: Int
}
