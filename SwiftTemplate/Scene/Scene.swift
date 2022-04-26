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
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        switch self {
        case .main(let mainViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "MainNav") as? UINavigationController else {
                fatalError()
            }
            guard var vc = nav.viewControllers.first as? ViewController else { fatalError() }
            DispatchQueue.main.async {
                print("#####")
                vc.bind(viewModel: mainViewModel)
            }
            return nav
        }
    }
}
