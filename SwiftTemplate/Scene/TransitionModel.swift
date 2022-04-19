//
//  TransitionModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransistionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
