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
    
    // save some transition info to find view on the screen.
    // When you use table, you need save cell info to find cell after table reloading.
    enum TransitionInfo {
        case pig
        case map
    }
    
    // we need save transition, because transitioningDelegate is weak
    private var alphaTransition: AlphaTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Animated Transitions"
    }
    
    // MARK: example 1: Segue
    
    @IBAction func pigButtonAction(_ sender: PigButton) {
        self.performSegue(withIdentifier: "openPigDetails", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if nil != sender as? PigButton {
            let vc = segue.destination
            self.alphaTransition = AlphaTransition(userInfo: TransitionInfo.pig, presenterVC: self)
            vc.transitioningDelegate = self.alphaTransition
        }
    }
    
    // MARK: example 2: by code
    
    @IBAction func mapButtonAction(_ sender: MapButton) {
        guard let vc = MapViewController.loadFromStoryboard("Main") else {
            return
        }
        self.alphaTransition = AlphaTransition(userInfo: TransitionInfo.map, presenterVC: self)
        vc.transitioningDelegate = self.alphaTransition
        self.present(vc, animated: true, completion: nil)
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
        }
    }
    
}
