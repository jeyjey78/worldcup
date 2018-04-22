//
//  AppFlow.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 21/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class AppFlow: Flow {
    
    private var rootFlow: UIViewController!
    
    init () {
        
    }
    
    func start() -> UIViewController {
        self.rootFlow = LoginViewController(self)
        return self.rootFlow
    }
}


// MARK: - Protocol
protocol AppFlowDelegate {
    func continueToProfile()
}


// MARK: - AppFlow Delegate
extension AppFlow: AppFlowDelegate {
    
    func continueToProfile() {
        let profileController = ProfileFlow().start()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIView.transition(from: appDelegate.window!.rootViewController!.view, to: profileController.view, duration: 0.65, options: [], completion: { (finished) in
            appDelegate.window!.rootViewController = profileController
            
        })
    }
}
