//
//  ProfileNavigationController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 24/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class ProfileNavigationController: UINavigationController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
        self.isNavigationBarHidden = true
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

// MARK: - UIGestureRecognizer Delegate
extension ProfileNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer is UIScreenEdgePanGestureRecognizer else { return true }
        return self.viewControllers.count > 1
    }
}


// MARK: - UINavigationController Delegate
extension ProfileNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = self.viewControllers.count > 1
    }
}
