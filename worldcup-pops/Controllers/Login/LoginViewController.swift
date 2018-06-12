//
//  LoginViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 21/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuthUI
import FBSDKLoginKit

class LoginViewController: UIViewController {

    var appdelegate: AppFlowDelegate
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var fifaImageView = UIImageView(image: UIImage(named: "fifa-logo"))
    fileprivate var loader = UIActivityIndicatorView()
    fileprivate var facebookButton = UIButton()
    
    fileprivate var playLoader = false {
        didSet {
            if oldValue != self.playLoader {
                self.loader.isHidden = !self.playLoader
                self.playLoader ? self.loader.startAnimating() : self.loader.stopAnimating()
            }
        }
    }
    
    
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
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: 260.0, height: 50.0)
        gradient.colors = [UIColor.messengerBlueDark.cgColor, UIColor.messengerBlueLight.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = 25.0
        
        self.facebookButton.layer.insertSublayer(gradient, below: nil)
        self.facebookButton.setTitle("Connexion", for: .normal)
        self.facebookButton.setTitleColor(UIColor.white, for: .normal)
        self.facebookButton.titleLabel?.font = UIFont.circularStdBlack(17.0)
        self.facebookButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(self.facebookButton)
        self.facebookButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(54.0)
            make.width.equalTo(260.0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-40.0)
        }
        
        let imageView = UIImageView(image: UIImage(named: "facebook-icon"))
        imageView.contentMode = .scaleAspectFit
        self.facebookButton.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(21.0)
            make.left.equalTo(self.facebookButton.snp.left).offset(25.0)
            make.centerY.equalTo(self.facebookButton)
        }
        
        // Loader
        self.loader.activityIndicatorViewStyle = .white
        self.loader.isHidden = true
        self.facebookButton.addSubview(self.loader)
        self.loader.snp.makeConstraints { (make) in
            make.right.equalTo(self.facebookButton.snp.right).offset(-15.0)
            make.centerY.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 11, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        // Bottom safe area
        let bottomSafeArea: CGFloat = self.view.safeAreaInsets.bottom
        
        self.facebookButton.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-40.0 - bottomSafeArea)
        }
    }
    
    
    // MARK: - Actions
    @objc func loginAction() {
        self.handleCustomFBLogin()
    }

    @objc func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            if err != nil {
                return
            }
            
            self.playLoader = true
            self.facebookProfileDetails()
        }
    }

    func facebookProfileDetails() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, first_name, email, picture.type(large)"]).start { (connection, result, err) in
            if err != nil {
                self.playLoader = false
                
                return
            }
            
            guard let data = result as? [String:Any] else { return }
            
            let username = data["first_name"] ?? ""
            
            let defaults = UserDefaults.standard
            defaults.set(username , forKey: Constants.username)
            
            if let picture = data["picture"] as? [String: Any] {
                if let dataPicture = picture["data"] as? [String: Any] {
                    if let url = dataPicture["url"] as? String {
                        
                    }
                }
            }
            
            self.logInFirebaseWithFacebook()
        }
    }

    func logInFirebaseWithFacebook() {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if let error = error {
                self.playLoader = false
                
                return
            }
            
            guard let user = user else {
                if let error = error {
                    self.playLoader = false
                    log.errorMessage(error.localizedDescription)
                }
                
                return
            }
            
            // stock firebase uid
            let defaults = UserDefaults.standard
            defaults.set(user.uid , forKey: Constants.firebaseId)
            self.playLoader = false
            self.appdelegate.continueToProfile()
        }
    }
}
