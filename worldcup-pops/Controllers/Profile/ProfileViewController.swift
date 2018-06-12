//
//  ProfileViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 22/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import FirebaseDatabase
import JASON

class ProfileViewController: UIViewController {

    var flowDelegate: ProfileFlow?
    var country: FIRDatabaseReference!
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var profilePicture = UIImageView(image: UIImage(named: "profile"))
    fileprivate var popsImageView = UIImageView(image: UIImage(named: "pops-icon"))
    
    fileprivate var scoreView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    fileprivate var matchsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Matchs\ndu jour", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(17.0)
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = UIColor.white
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5.0
        button.layer.cornerRadius = 50.0
        return button
    }()
    
    fileprivate var betButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mes paris", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(17.0)
        button.backgroundColor = UIColor.white
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5.0
        button.layer.cornerRadius = 50.0
        return button
    }()
    
    fileprivate var countryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pays", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(17.0)
        button.backgroundColor = UIColor.white
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5.0
        button.layer.cornerRadius = 50.0
        return button
    }()
    
    fileprivate var pseudoLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.circularStdMedium(21.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate var winLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.font = UIFont.circularStdBold(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 24.0 : 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.text = "2 win - 0 lose"
        return label
    }()
    
    
    // MARK: - Life cycle
    init(_ delegate: ProfileFlow) {
        self.flowDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pseudoLabel.text = UserDefaults.standard.object(forKey: Constants.username) as! String
        
        // Background
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // Match button
        self.matchsButton.addTarget(self, action: #selector(continueToDayMatch), for: .touchUpInside)
        self.view.addSubview(self.matchsButton)
        self.matchsButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.left.equalTo(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 30.0 : 40.0)
            make.top.equalTo(self.view.snp.top).offset(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? Screen.size.height * 0.1 : Screen.size.height * 0.15)
        }
        
        // Score view
        self.view.addSubview(self.scoreView)
        self.scoreView.snp.makeConstraints { (make) in
            make.height.equalTo(150.0)
            make.width.equalTo(150.0)
            make.right.equalTo(self.view.snp.right).offset(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? -30.0 : -50.0)
            make.top.equalTo(self.view.snp.top).offset(Screen.size.height * 0.15)
        }
        
        // Pops icon
        self.scoreView.addSubview(self.popsImageView)
        self.popsImageView.snp.makeConstraints { (make) in
            make.height.equalTo(51.0)
            make.width.equalTo(31.0)
            make.centerX.equalTo(self.scoreView)
            make.top.equalToSuperview()
        }
        
        // Win label
        self.scoreView.transform = CGAffineTransform(rotationAngle: 0.3)
        self.scoreView.addSubview(self.winLabel)
        self.winLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(150.0)
            make.right.equalTo(self.scoreView.snp.right)
            make.top.equalTo(self.popsImageView.snp.bottom)
        }
        
        // Profile Picture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectCountryAction))
        self.profilePicture.isUserInteractionEnabled = true
        self.profilePicture.addGestureRecognizer(gesture)
        self.view.addSubview(self.profilePicture)
        self.profilePicture.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(150.0)
        }
        
        // Pseudo label
        self.view.addSubview(self.pseudoLabel)
        self.pseudoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.profilePicture.snp.bottom).offset(5.0)
            make.height.equalTo(20.0)
            make.width.equalTo(200.0)
        }
        
        // Bet button
        self.betButton.addTarget(self, action: #selector(continueToBet), for: .touchUpInside)
        self.view.addSubview(self.betButton)
        self.betButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.left.equalTo(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 35.0 : 60.0)
            make.top.equalTo(self.pseudoLabel.snp.bottom).offset(Screen.size.height * 0.05)
        }
        
        // Country button
        self.countryButton.addTarget(self, action: #selector(continueToCountries), for: .touchUpInside)
        self.view.addSubview(self.countryButton)
        self.countryButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.right.equalTo(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? -35.0 : -50.0)
            make.top.equalTo(self.pseudoLabel.snp.bottom).offset(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? Screen.size.height * 0.1 : Screen.size.height * 0.15)
        }

        self.setProfilePicture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @objc func continueToCountries() {
        self.flowDelegate?.continueToCountries(self)
    }
    
    @objc func continueToBet() {
        self.flowDelegate?.continueToOwnerBet(self)
    }
    
    @objc func continueToDayMatch() {
        self.flowDelegate?.continueToDayMatch(self)
    }
    
    @objc func selectCountryAction() {
        self.flowDelegate?.continueToSelectCountry()
    }
    
    func setProfilePicture() {
        if let country = UserDefaults.standard.object(forKey: Constants.userCountry) as? String {
            self.profilePicture.image = UIImage(named: "flag-\(country)")
            self.animeProfilePicture()
        }
        else {
            self.profilePicture.image = UIImage(named: "profile")
        }
    }
    
    
    // Animation
    func animeProfilePicture() {
        Queue.main {
            UIView.animate(withDuration: 0.4, delay: 1.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
                self.profilePicture.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }, completion: nil)
            
            UIView.animate(withDuration: 1.0, delay: 1.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
                self.profilePicture.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
            }, completion: { (_) in
                self.profilePicture.transform = CGAffineTransform.identity
            })
        }
    }
}
