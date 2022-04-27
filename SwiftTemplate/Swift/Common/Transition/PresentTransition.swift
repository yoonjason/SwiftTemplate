//
//  PresentTransition.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/27.
//

import Foundation
import UIKit

enum Constants {
    static let duration = 1.0
}

class PresentTransition: NSObject {
    
}

extension PresentTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    
}
