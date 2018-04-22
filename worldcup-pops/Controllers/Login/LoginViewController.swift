//
//  LoginViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 21/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var appdelegate: AppFlowDelegate
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var fifaImageView = UIImageView(image: UIImage(named: "fifa-logo"))
    
    fileprivate var facebookButton = UIButton()
    
    // MARK: - life cycle
    init(_ delegate: AppFlowDelegate) {
        self.appdelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // fifa logo
        self.view.addSubview(self.fifaImageView)
        self.fifaImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(254.0)
            make.width.equalTo(230.0)
            make.top.equalTo(self.view.snp.top).offset(150.0)
        }
        
        // Facebook button
        // Gradient
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: Screen.size.width*0.72, height: 50.0)
        gradient.colors = [UIColor.messengerBlueDark.cgColor, UIColor.messengerBlueLight.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = 25.0
        
        self.facebookButton.layer.insertSublayer(gradient, below: nil)
        self.facebookButton.setTitle("Se connecter", for: .normal)
        self.facebookButton.setTitleColor(UIColor.white, for: .normal)
        self.facebookButton.titleLabel?.font = UIFont.circularStdBlack(17.0)
        self.facebookButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(self.facebookButton)
        self.facebookButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(54.0)
            make.width.equalTo(270.0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-40.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @objc func loginAction() {
        self.appdelegate.continueToProfile()
    }
}
