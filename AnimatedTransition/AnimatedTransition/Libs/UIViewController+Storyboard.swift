//
//  UIViewController+Storyboard.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    class func loadFromStoryboard(_ name: String) -> UIViewController? {
        let storyboard = UIStoryboard.init(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.storyboardIdentifier)
    }
    
}
