//
//  AppDelegate.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let coordinator = SceneCoordinator(window: window!)
//        let api = Api()
//        let viewModel = MainViewModel(
//            api: api,
//            sceneCoordinator: coordinator)
//        let scene = Scene.main(viewModel)
//        coordinator.transition(to: scene, using: .root, animated: true)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        return true
    }

    private func setting() {
//        let navigatonController = UINavigationController(rootViewController: ViewController())
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigatonController
//        window?.makeKeyAndVisible()
     
    }

}

