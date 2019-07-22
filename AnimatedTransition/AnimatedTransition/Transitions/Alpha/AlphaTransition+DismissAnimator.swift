//
//  AlphaTransition+DismissAnimator.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension AlphaTransition {
    
    class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        /// Animation duration
        let duration = 0.65
        
        let presenterInfo: AlphaTransition.PresenterInfo
        let presentableInfo: AlphaTransition.PresentableInfo
        
        init(presenterInfo: AlphaTransition.PresenterInfo, presentableInfo: AlphaTransition.PresentableInfo) {
            self.presenterInfo = presenterInfo
            self.presentableInfo = presentableInfo
        }
        
        // MARK: UIViewControllerAnimatedTransitioning
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return duration
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
            guard let destinationVC = transitionContext.viewController(forKey: .to) else { return }
            
            //Add destination view behind
            transitionContext.containerView.insertSubview(destinationVC.view, at: 0)
            transitionContext.containerView.addSubview(self.presenterInfo.alphaView)
            self.presentableInfo.prepare()
            self.presenterInfo.prepare()
            self.presenterInfo.alphaView.frame = transitionContext.containerView.bounds
            self.presenterInfo.alphaView.alpha = 0
            transitionContext.containerView.layoutIfNeeded()
            
            //Prepare the animator
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
                fromVC.view.frame = self.presenterInfo.frame
                destinationVC.view.layoutIfNeeded()
                self.presentableInfo.animation()
                self.presenterInfo.animation()
                self.presenterInfo.alphaView.frame = self.presenterInfo.frame
                self.presenterInfo.alphaView.alpha = 1
            }
            
            animator.addCompletion { _ in
                fromVC.view.removeFromSuperview()
                self.presenterInfo.alphaView.removeFromSuperview()
                self.presentableInfo.finish()
                self.presenterInfo.finish()
                transitionContext.completeTransition(true)
            }
            
            //Start the animation
            animator.startAnimation()
        }
    }
}
