//
//  PigViewController.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

class PigViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showCloseButtonAnimated() {
        self.closeButton.isHidden = false
        let closeButton = UIImageView(image: self.closeButton.snapshot)
        self.closeButton.isHidden = true
        self.view.addSubview(closeButton)
        closeButton.layer.allowsEdgeAntialiasing = true
        closeButton.frame = self.closeButton.frame
        let transform = CGAffineTransform.identity.translatedBy(x: -closeButton.frame.maxX, y: 0).rotated(by: CGFloat.pi * -0.99).scaledBy(x: 0.5, y: 0.5)
        closeButton.transform = transform
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            closeButton.transform = .identity
        }, completion: { (_) in
            closeButton.removeFromSuperview()
            self.closeButton.isHidden = false
        })
    }
    
}

extension PigViewController: AlphaTransitionPresentable {
    
    func presentingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        return AlphaTransition.PresentableInfo(prepare: {
            self.closeButton.isHidden = true
        }, animation: {}, finish: {
            self.showCloseButtonAnimated()
        })
    }
    
    func dismissingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        return AlphaTransition.PresentableInfo(prepare: {}, animation: {}, finish: {})
    }
    
}
