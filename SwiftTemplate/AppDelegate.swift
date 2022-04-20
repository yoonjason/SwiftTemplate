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
        setting()
        return true
    }

    private func setting() {
        let navigatonController = UINavigationController(rootViewController: ViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigatonController
        window?.makeKeyAndVisible()
        let sceneCoordinator = SceneCoordinator(window: window!)
        let api = Api()
        let viewModel = MainViewModel(
            api: api,
            sceneCoordinator: sceneCoordinator)
        let scene = Scene.main(viewModel)
        sceneCoordinator.transition(to: scene, using: .root, animated: true)


    }

}

