//
//  Scene.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation
import UIKit

enum Scene {
    case main(MainViewModel)
}

extension Scene {
    func instantiate() -> UIViewController {
        switch self {
        case .main(let mainViewModel):
            var vc = ViewController()
            DispatchQueue.main.async {
                vc.bindViewModel()
            }
            return vc
        }
    }
}
