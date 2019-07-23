//
//  MenuViewController.swift
//  AnimatedTransition
//
//  Created by Yanis Plumit on 17/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var pigButton: PigButton!
    @IBOutlet weak var mapButton: MapButton!
    @IBOutlet weak var toFrameButton: PigButton!
    @IBOutlet weak var withoutAlphaButton: SmallImageButton!
    
    // save some transition info to find view on the screen.
    // When you use table, you need save cell info to find cell after table reloading.
    enum TransitionInfo {
        case pig
        case map
        case toFrame
        case withoutAlpha
    }
    
    // we need save transition, because transitioningDelegate is weak
    private var alphaTransition: AlphaTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Animated Transitions"
    }
    
    // MARK: example 1: Segue
    
    @IBAction func pigButtonAction(_ sender: Any?) {
        self.performSegue(withIdentifier: "openPigDetails", sender: TransitionInfo.pig)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let transitionInfo = sender as? TransitionInfo {
            let vc = segue.destination
            self.alphaTransition = AlphaTransition(userInfo: transitionInfo, presenterVC: self)
            vc.transitioningDelegate = self.alphaTransition
        }
    }
    
    // MARK: example 2: by code
    
    @IBAction func mapButtonAction(_ sender: Any?) {
        guard let vc = MapViewController.loadFromStoryboard("Main") else {
            return
        }
        self.alphaTransition = AlphaTransition(userInfo: TransitionInfo.map, presenterVC: self)
        vc.transitioningDelegate = self.alphaTransition
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: example 3: to frame.
    // images should have same proportions, otherwise you can see some glitches while animation. So see exemple 4 to avoid this
    
    @IBAction func toFrameButtonAction(_ sender: Any?) {
        self.performSegue(withIdentifier: "openToFrameDetails", sender: TransitionInfo.toFrame)
    }
    
    // MARK: example 4: to frame without Alpha.
    
    @IBAction func withoutAlphaButtonAction(_ sender: Any?) {
        self.performSegue(withIdentifier: "openWithoutAlphaDetails", sender: TransitionInfo.withoutAlpha)
    }
    
}

extension MenuViewController: AlphaTransitionPresenter {
    
    func presentingPresenterInfo(transition: AlphaTransition) -> AlphaTransition.PresenterInfo? {
        guard let transitionInfo = transition.userInfo as? TransitionInfo else {
            return nil
        }
        
        switch transitionInfo {
        case .pig:
            return self.pigButton.presentingInfo(inView: self.view)
        case .map:
            return self.mapButton.presentingInfo(inView: self.view)
        case .toFrame:
            return self.toFrameButton.presentingInfo(inView: self.view)
        case .withoutAlpha:
            return self.withoutAlphaButton.presentingInfo(inView: self.view)
        }
    }
    
    func dismissingPresenterInfo(transition: AlphaTransition) -> AlphaTransition.PresenterInfo? {
        guard let transitionInfo = transition.userInfo as? TransitionInfo else {
            return nil
        }
        
        switch transitionInfo {
        case .pig:
            return self.pigButton.dismissingInfo(inView: self.view)
        case .map:
            return self.mapButton.dismissingInfo(inView: self.view)
        case .toFrame:
            return self.toFrameButton.dismissingInfo(inView: self.view)
        case .withoutAlpha:
            return self.withoutAlphaButton.dismissingInfo(inView: self.view)
        }
    }
    
}
