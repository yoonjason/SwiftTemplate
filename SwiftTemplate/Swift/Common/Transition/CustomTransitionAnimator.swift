//
//  PresentTransition.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/27.
//

import Foundation
import UIKit

enum AnimationType {
    case present
    case dismiss
}

enum Constants {
    static let duration = 1.0
    static var originFrame = CGRect.zero
    static let affineTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
}

class CustomTransitionAnimator: NSObject {
    let animationType: AnimationType
    let selectedIndexPath: IndexPath
    var originPoint: CGPoint?
    var originFrame: CGRect?

    init(animationType: AnimationType,
         selectedIndexPath: IndexPath
    ) {
        self.animationType = animationType
        self.selectedIndexPath = selectedIndexPath
        super.init()
    }

    func setPoint(point p: CGPoint?) {
        self.originPoint = p
    }

    func setFrame(frame f: CGRect?) {
        self.originFrame = f
    }

}

extension CustomTransitionAnimator {
    func presentTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toVC = transitionContext.viewController(forKey: .to) as? NormalDetailViewController else { return }
        guard let fromVC = transitionContext.viewController(forKey: .from) as? UINavigationController else { return }
        guard let mainVC = fromVC.viewControllers.first as? NormalMainViewController else { return }
        guard let cell = mainVC.collectionView.cellForItem(at: self.selectedIndexPath) as? ThumbPhotoCell else { return }
        guard let toView = toVC.view else { return }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        
//        toView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//          toView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
//          toView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
//          toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//          toView.topAnchor.constraint(equalTo: containerView.topAnchor),
//        ])
        
//        toView.transform = CGAffineTransform(scaleX: 1, y: 1)

   

        toView.layer.masksToBounds = true
        toView.layer.cornerRadius = 20
        toView.alpha = 0
        
        let animationView = UIView(frame: toView.frame)
        animationView.backgroundColor = .red
        let imageView = UIImageView(frame: cell.imageView.superview!.convert(cell.imageView.frame, to: animationView))
        imageView.image = cell.imageView.image
        imageView.contentMode = cell.imageView.contentMode
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)
        
        let animation = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.8) {
            
            imageView.frame = toView.frame
        }
        animation.addCompletion { (_) in
            toView.alpha = 1
//            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        animation.startAnimation()
    }

    func dismissTransition(using transitionContext: UIViewControllerContextTransitioning) {

    }
}

extension CustomTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if animationType == .present {
            presentTransition(using: transitionContext)
        } else {
            dismissTransition(using: transitionContext)
        }
    }


}
