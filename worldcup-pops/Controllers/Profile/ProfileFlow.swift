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
    
    var navigation: ProfileNavigationController!
    var appFlowDelegate: AppFlowDelegate?
    
    init () {
        let shopController = ProfileViewController(self)
        shopController.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigation = ProfileNavigationController(rootViewController: shopController)
    }
    
    func start() -> UIViewController {
        
        return self.navigation
    }
}


// MARK: - Protocol
protocol ProfileFlowDelegate {
    
    func continueToCountries(_ controller: UIViewController)
    
    func backProfile(_ controller: UIViewController)
}


// MARK: - AppFlow Delegate
extension ProfileFlow: ProfileFlowDelegate {
    
    // MARK: - Continue to
    func continueToCountries(_ controller: UIViewController) {
        let countriesController = CountriesViewController()
        countriesController.flowDelegate = self
        
        self.navigation.pushViewController(countriesController, animated: true)
    }
    
    // MARK: - Back
    func backProfile(_ controller: UIViewController) {
        self.navigation.popViewController(animated: true)
    }
}
