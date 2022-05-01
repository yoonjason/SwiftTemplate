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
    var originPoint: CGPoint?
    var originFrame: CGRect?
    var indexPathManager = ImageIndexPathManager.shared

    init(animationType: AnimationType
    ) {
        self.animationType = animationType
        super.init()
    }

}

extension CustomTransitionAnimator {
    func presentTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toVC = transitionContext.viewController(forKey: .to) as? NormalDetailViewController else { return }
        guard let fromVC = transitionContext.viewController(forKey: .from) as? UINavigationController else { return }
        guard let mainVC = fromVC.viewControllers.first as? NormalMainViewController else { return }
        guard let fromCell = mainVC.collectionView.cellForItem(at: indexPathManager.selectedIndexPath) as? ThumbPhotoCell else { return }
        guard let toView = toVC.view else { return }
        guard let toCell = toVC.collectionView.cellForItem(at: indexPathManager.selectedIndexPath) as? PhotoViewerCell else { return }


        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)

        toView.layer.masksToBounds = true
        toView.layer.cornerRadius = 20
        toView.alpha = 0

        let animationView = UIView(frame: toView.frame)
        animationView.backgroundColor = .white
        let imageView = UIImageView(frame: fromCell.imageView.superview!.convert(fromCell.imageView.frame, to: animationView))
        imageView.image = fromCell.imageView.image
        imageView.contentMode = .scaleAspectFit
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: toView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: toView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: animationView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor)
        ])

        let animation = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.8) {
            imageView.frame = toCell.imageView.frame
        }
        animation.addCompletion { (_) in
            toView.alpha = 1
            toCell.imageView.image = imageView.image
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        animation.startAnimation()
    }


    func dismissTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presented = transitionContext.viewController(forKey: .from) as? NormalDetailViewController,
            let presenting = (transitionContext.viewController(forKey: .to) as? UINavigationController)?.topViewController as? NormalMainViewController,
            let presentedCell = presented.collectionView.cellForItem(at: indexPathManager.selectedIndexPath) as? PhotoViewerCell,
            let transitionableCell = presenting.collectionView.cellForItem(at: indexPathManager.selectedIndexPath) as? ThumbPhotoCell,
            let toView = transitionContext.view(forKey: .to)
            else
        { transitionContext.cancelInteractiveTransition()
            return
        }

        let containerView = transitionContext.containerView
        let animationView = UIView(frame: presented.view.frame)
        containerView.addSubview(toView)

        let backgroundView = UIView(frame: animationView.frame)
        backgroundView.backgroundColor = .white
        animationView.addSubview(backgroundView)

        let imageView = UIImageView(image: presentedCell.imageView.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = presentedCell.imageView.frame
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)

        let destinationFrame = transitionableCell.imageView.superview!.convert(transitionableCell.imageView.frame, to: containerView)
        let cellBackgroundView = UIView(frame: destinationFrame)
        cellBackgroundView.backgroundColor = .clear
        containerView.insertSubview(cellBackgroundView, aboveSubview: presenting.view)

        UIView.animate(withDuration: 0.5, animations: {
            backgroundView.alpha = 0
            imageView.frame = destinationFrame
        }) { (_) in
            cellBackgroundView.removeFromSuperview()
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
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
