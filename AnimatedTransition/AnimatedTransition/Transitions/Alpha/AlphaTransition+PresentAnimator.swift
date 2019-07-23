//
//  AlphaTransition+PresentAnimator.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension AlphaTransition {
    
    class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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
            //            guard let fromVC = transitionContext.viewController(forKey: .to) else { return }
            guard let destinationVC = transitionContext.viewController(forKey: .to) else { return }
            
            if destinationVC.view.clipsToBounds == false {
                NSLog("WARNING: Please, set \(String(describing: destinationVC.self)).view.clipsToBounds = true")
            }
            
            //Add destination view to the container at the position of the cell
            transitionContext.containerView.addSubview(destinationVC.view)
            transitionContext.containerView.addSubview(self.presenterInfo.alphaView)
            self.presentableInfo.prepare()
            self.presenterInfo.prepare()
            destinationVC.view.frame = self.presenterInfo.frame
            self.presenterInfo.alphaView.frame = self.presenterInfo.frame
            self.presenterInfo.alphaView.alpha = 1
            transitionContext.containerView.layoutIfNeeded()
            
            //Prepare the animator
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
                destinationVC.view.layoutIfNeeded()
                destinationVC.view.frame = transitionContext.containerView.bounds
                self.presentableInfo.animation()
                self.presenterInfo.animation()
                self.presenterInfo.alphaView.frame = self.presentableInfo.frame ?? transitionContext.containerView.bounds
                self.presenterInfo.alphaView.alpha = self.presentableInfo.byAlpha ? 0 : 1
            }
            
            animator.addCompletion { (_) in
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
