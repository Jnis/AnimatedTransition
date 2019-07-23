//
//  ToFrameViewController.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 23/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

class ToFrameViewController: UIViewController {
    @IBOutlet weak var pigImageView: UIImageView!
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ToFrameViewController: AlphaTransitionPresentable {
    
    func presentingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        let imageFrame = pigImageView.frame
        return AlphaTransition.PresentableInfo(frame: imageFrame, prepare: {}, animation: {}, finish: {})
    }
    
    func dismissingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        let imageFrame = pigImageView.frame
        return AlphaTransition.PresentableInfo(frame: imageFrame, prepare: {}, animation: {}, finish: {})
    }
    
}
