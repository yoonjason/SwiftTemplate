//
//  SplashViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit

class SplashViewController: UIViewController {
    
    var window = UIWindow.key

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.setupViews()
            self.window?.rootViewController = self
        }
    }

    private func setupViews() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let alert = UIAlertController(title: "안내", message: "RxSwift? Swift?", preferredStyle: .alert)
        let rxAction = UIAlertAction(title: "RxSwift", style: .default) { [self] _ in
            let coordinator = SceneCoordinator(window: window!)
            let api = Api()
            let viewModel = MainViewModel(
                api: api,
                sceneCoordinator: coordinator)
            let scene = Scene.main(viewModel)
            coordinator.transition(to: scene, using: .root, animated: true)
            window?.makeKeyAndVisible()
        }
        let normalSwiftAction = UIAlertAction(title: "Normal Swift", style: .default) { [self] _ in
            let storyboard = UIStoryboard(name: "NormalMain", bundle: nil)
            guard let nav = storyboard.instantiateViewController(withIdentifier: "NormalNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var vc = nav.viewControllers.first as? NormalMainViewController else { fatalError() }
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            exit(0)
        }
        alert.addAction(rxAction)
        alert.addAction(normalSwiftAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}

public extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            print("@#####11")
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            print("@#####222")
            return UIApplication.shared.keyWindow
        }
    }
}
