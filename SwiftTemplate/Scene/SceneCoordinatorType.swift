//
//  SceneCoordinatorType.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    
    @discardableResult
    func transition(to Scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
