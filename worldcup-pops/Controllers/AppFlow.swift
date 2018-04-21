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
        self.rootFlow = LoginViewController()
        return self.rootFlow
    }
}


// MARK: - Protocol
protocol AppFlowDelegate {
    
}


// MARK: - AppFlow Delegate
extension AppFlow: AppFlowDelegate {
    
}
