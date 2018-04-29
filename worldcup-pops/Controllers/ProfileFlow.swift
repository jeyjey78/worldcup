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
    func continueToOwnerBet(_ controller: UIViewController)
    func continueToMatch(_ controller: UIViewController)
    func continueToMatchCountry(_ controller: UIViewController)
    
    func backProfile(_ controller: UIViewController)
    func backAction(_ controller: UIViewController)
}


// MARK: - AppFlow Delegate
extension ProfileFlow: ProfileFlowDelegate {
    
    // MARK: - Continue to
    func continueToCountries(_ controller: UIViewController) {
        let countriesController = CountriesViewController()
        countriesController.flowDelegate = self
        
        self.navigation.pushViewController(countriesController, animated: true)
    }
    
    func continueToOwnerBet(_ controller: UIViewController) {
        let betController = BetViewController()
        betController.flowDelegate = self
        
        self.navigation.pushViewController(betController, animated: true)
    }
    
    func continueToMatch(_ controller: UIViewController) {
        let matchController = MatchBetViewController()
        matchController.flowDelegate = self
        
        self.navigation.pushViewController(matchController, animated: true)
    }
    
    func continueToMatchCountry(_ controller: UIViewController) {
        let matchController = MatchCountryViewController()
        matchController.flowDelegate = self
        
        self.navigation.pushViewController(matchController, animated: true)
    }
    
    
    // MARK: - Back
    func backProfile(_ controller: UIViewController) {
        self.navigation.popViewController(animated: true)
    }
    
    func backAction(_ controller: UIViewController) {
        self.navigation.popViewController(animated: true)
    }
}
