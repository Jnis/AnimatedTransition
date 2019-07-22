//
//  AlphaTransition.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 18/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension AlphaTransition {
    
    struct PresenterInfo {
        let frame: CGRect
        let alphaView: UIView
        let prepare: () -> Void
        let animation: () -> Void
        let finish: () -> Void
    }
    
    struct PresentableInfo {
        let prepare: () -> Void
        let animation: () -> Void
        let finish: () -> Void
    }
    
}

protocol AlphaTransitionPresenter {
    func presentingPresenterInfo(transition: AlphaTransition) -> AlphaTransition.PresenterInfo?
    func dismissingPresenterInfo(transition: AlphaTransition) -> AlphaTransition.PresenterInfo?
}

protocol AlphaTransitionPresentable {
    func presentingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo?
    func dismissingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo?
}

class AlphaTransition: NSObject {
    let userInfo: Any?
    weak var presenterVC: (AlphaTransitionPresenter & UIViewController)?
    
    init(userInfo: Any?, presenterVC: (AlphaTransitionPresenter & UIViewController)) {
        self.userInfo = userInfo
        self.presenterVC = presenterVC
        super.init()
    }
}

extension AlphaTransition: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let presentable = presented as? AlphaTransitionPresentable,
            let presentableInfo = presentable.presentingPresentableInfo(transition: self),
            let presenterInfo = presenterVC?.presentingPresenterInfo(transition: self) {
            return PresentAnimator(presenterInfo: presenterInfo, presentableInfo: presentableInfo)
        } else {
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let presentable = dismissed as? AlphaTransitionPresentable,
            let presentableInfo = presentable.dismissingPresentableInfo(transition: self),
            let presenterInfo = presenterVC?.dismissingPresenterInfo(transition: self) {
            return DismissAnimator(presenterInfo: presenterInfo, presentableInfo: presentableInfo)
        } else {
            return nil
        }
    }
    
}
