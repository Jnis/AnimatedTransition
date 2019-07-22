//
//  UIView+Nib.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func defaultSetupNib() -> UIView? {
        guard let view = loadViewFromNib() else { return nil }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
