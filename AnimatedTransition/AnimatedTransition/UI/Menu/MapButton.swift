//
//  MapButton.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//@IBDesignable
class MapButton: UIButton {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapLabel: UILabel!
    
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
        mapView.resetToDemoView()
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.5 : 1
        }
    }
    
    private var presenterCachedAlphaView: UIView?
}

// MARK: - AlphaPresentation

extension MapButton {
    
    private func presenterAlphaView() -> UIView {
        let v = mapView.snapshotView(afterScreenUpdates: true) ?? UIView()
        v.contentMode = .scaleAspectFill
        return v
    }
    
    func presentingInfo(inView: UIView) -> AlphaTransition.PresenterInfo {
        presenterCachedAlphaView = presenterAlphaView()
        return AlphaTransition.PresenterInfo(frame: mapView.convert(mapView.bounds, to: inView),
                                             alphaView: presenterCachedAlphaView ?? presenterAlphaView(),
                                             prepare: {
                                                self.mapLabel.alpha = 0
        },
                                             animation: {
                                                self.mapView.alpha = 0
        },
                                             finish: {
                                                self.mapLabel.alpha = 1
                                                self.mapView.alpha = 1
        })
    }
    
    func dismissingInfo(inView: UIView) -> AlphaTransition.PresenterInfo {
        return AlphaTransition.PresenterInfo(frame: mapView.convert(mapView.bounds, to: inView),
                                             alphaView: presenterCachedAlphaView ?? presenterAlphaView(),
                                             prepare: {
                                                self.mapView.alpha = 0
                                                self.mapLabel.alpha = 0
        },
                                             animation: {},
                                             finish: {
                                                self.presenterCachedAlphaView = nil
                                                self.mapView.alpha = 1
                                                self.mapLabel.alpha = 1
                                                self.mapLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
                                                UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.7) {
                                                    self.mapLabel.transform = .identity
                                                    }.startAnimation()
        })
    }
}
