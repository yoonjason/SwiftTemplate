//
//  SceneCoordinator.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation
import RxCocoa
import RxSwift

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.last ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    
    private let window: UIWindow
    private var currentVC: UIViewController
    private let bag = DisposeBag()
    
    init(
        window: UIWindow
    ){
        self.window = window
        self.currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Never>()
        let target = scene.instantiate()
        
        switch style {
        case .root:
            print(target.sceneViewController)
            currentVC = target.sceneViewController
            window.rootViewController = target

            subject.onCompleted()
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransistionError.navigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .withUnretained(self)
                .subscribe(onNext: { coordinator, event in
                    coordinator.currentVC = event.viewController.sceneViewController
                })
                .disposed(by: bag)
            
            nav.pushViewController(target, animated: true)
            currentVC = target.sceneViewController
            subject.onCompleted()
        case .modal:
            break
        }
        
        return subject.asCompletable()
    }
    
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            return Disposables.create()
        }
    }
    
    
}
