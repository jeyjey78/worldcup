//
//  ProfileFlow.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 22/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class ProfileFlow: Flow {
    
    private var rootFlow: UIViewController!
    
    var appFlowDelegate: AppFlowDelegate?
    
    init () {
        
    }
    
    func start() -> UIViewController {
        self.rootFlow = ProfileViewController()
        return self.rootFlow
    }
}


// MARK: - Protocol
protocol ProfileFlowDelegate {
    
}


// MARK: - AppFlow Delegate
extension ProfileFlow: ProfileFlowDelegate {
    
}
