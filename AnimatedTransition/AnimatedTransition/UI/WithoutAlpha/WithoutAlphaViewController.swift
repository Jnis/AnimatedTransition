//
//  WithoutAlphaViewController.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 23/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

class WithoutAlphaViewController: UIViewController {
    @IBOutlet weak var pigImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WithoutAlphaViewController: AlphaTransitionPresentable {
    
    func presentingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        let imageFrame = pigImageView.frame
        return AlphaTransition.PresentableInfo(frame: imageFrame, byAlpha: false, prepare: {
            self.pigImageView.alpha = 0
            self.closeButton.alpha = 0
        }, animation: {}, finish: {
            self.pigImageView.alpha = 1
            UIView.animate(withDuration: 0.1, animations: {
                self.closeButton.alpha = 1
            })
        })
    }
    
    func dismissingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        let imageFrame = pigImageView.frame
        return AlphaTransition.PresentableInfo(frame: imageFrame, byAlpha: false, prepare: {
            self.pigImageView.alpha = 0
        }, animation: {}, finish: {
            self.pigImageView.alpha = 1
        })
    }
    
}
