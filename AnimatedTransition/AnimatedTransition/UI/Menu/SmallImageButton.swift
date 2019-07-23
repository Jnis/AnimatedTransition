//
//  SmallImageButton.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 23/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class SmallImageButton: UIButton {
    @IBOutlet weak var pigImageView: UIImageView!
    
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

extension SmallImageButton {
    
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
                                                self.pigImageView.alpha = 0
        }, animation: {}, finish: {
            self.pigImageView.alpha = 1
        })
    }
    
    func dismissingInfo(inView: UIView) -> AlphaTransition.PresenterInfo {
        return AlphaTransition.PresenterInfo(frame: pigImageView.convert(pigImageView.bounds, to: inView),
                                             alphaView: presenterAlphaView(),
                                             prepare: {
                                                self.pigImageView.alpha = 0
        }, animation: {}, finish: {
            self.pigImageView.alpha = 1
        })
    }
}
