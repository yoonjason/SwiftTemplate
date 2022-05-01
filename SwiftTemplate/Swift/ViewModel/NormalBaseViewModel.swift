//
//  NormalBaseViewModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/29.
//

import Foundation
import UIKit

protocol NormalBaseViewModel {
    func fetchPhotos(_ photoState: PhotoState)
    func downloadImage(_ photo: Photo, completion: @escaping (UIImage) -> Void)
}
