//
//  PigButton.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PigButton: UIButton {
    @IBOutlet weak var pigImageView: UIImageView!
    @IBOutlet weak var pigLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        _ = defaultSetupNib()
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.5 : 1
        }
    }
}

// MARK: AlphaTransition presentable

extension PigButton {
    
    func presenterAlphaView() -> UIView {
        let v = UIImageView()
        v.image = self.pigImageView.image
        v.clipsToBounds = true
        v.contentMode = self.pigImageView.contentMode
        return v
    }
    
    func presentingInfo(inView: UIView) -> AlphaTransition.PresenterInfo {
        return AlphaTransition.PresenterInfo(frame: pigImageView.convert(pigImageView.bounds, to: inView),
                                             alphaView: presenterAlphaView(),
                                             prepare: {
                                                self.pigLabel.alpha = 0
        },
                                             animation: {},
                                             finish: {
                                                self.pigLabel.alpha = 1
        })
    }
    
    func dismissingInfo(inView: UIView) -> AlphaTransition.PresenterInfo {
        return AlphaTransition.PresenterInfo(frame: pigImageView.convert(pigImageView.bounds, to: inView),
                                             alphaView: presenterAlphaView(),
                                             prepare: {
                                                self.pigLabel.alpha = 0
        },
                                             animation: {},
                                             finish: {
                                                self.pigLabel.alpha = 1
                                                self.pigLabel.transform = CGAffineTransform(translationX: 0, y: self.pigLabel.bounds.size.height)
                                                UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.7) {
                                                    self.pigLabel.transform = CGAffineTransform.identity
                                                    }.startAnimation()
                                                
        })
    }
}
