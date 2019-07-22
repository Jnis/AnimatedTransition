//
//  MapViewController.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 21/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension MKMapView {
    
    func resetToDemoView() {
        let animated = self.camera.altitude < 100000
        let bernCoords = CLLocationCoordinate2DMake(46.9479446, 7.4506844)
        let aspect = self.bounds.width > 0 ? Double(self.bounds.height / self.bounds.width) : 1
        let region = MKCoordinateRegion.init(center: bernCoords, latitudinalMeters: 1900 * aspect, longitudinalMeters: 0)
        self.setRegion(region, animated: animated)
    }
    
}

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.resetToDemoView()
    }
    
}

extension MapViewController: AlphaTransitionPresentable {
    
    func presentingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        return AlphaTransition.PresentableInfo(prepare: {}, animation: {}, finish: {})
    }
    
    func dismissingPresentableInfo(transition: AlphaTransition) -> AlphaTransition.PresentableInfo? {
        return AlphaTransition.PresentableInfo(prepare: {}, animation: {}, finish: {})
    }
    
}
