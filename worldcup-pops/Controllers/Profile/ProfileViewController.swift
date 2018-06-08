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
        button.setTitle("Matchs", for: .normal)
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
    
    fileprivate var betButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bet", for: .normal)
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
        button.setTitle("Countries", for: .normal)
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
        label.font = UIFont.circularStdBlack(17.0)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Jeremy"
        return label
    }()
    
    fileprivate var winLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.font = UIFont.circularStdBold(30.0)
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

        // Background
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // Match button
        self.view.addSubview(self.matchsButton)
        self.matchsButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.left.equalTo(40.0)
            make.top.equalTo(self.view.snp.top).offset(Screen.size.height * 0.15)
        }
        
        // Score view
        self.view.addSubview(self.scoreView)
        self.scoreView.snp.makeConstraints { (make) in
            make.height.equalTo(150.0)
            make.width.equalTo(150.0)
            make.right.equalTo(self.view.snp.right).offset(-50.0)
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
        self.view.addSubview(self.profilePicture)
        self.profilePicture.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(150.0)
        }
        
        // Pseudo label
        self.view.addSubview(self.pseudoLabel)
        self.pseudoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.profilePicture.snp.bottom).offset(10.0)
            make.height.equalTo(20.0)
            make.width.equalTo(200.0)
        }
        
        // Bet button
        self.betButton.addTarget(self, action: #selector(continueToBet), for: .touchUpInside)
        self.view.addSubview(self.betButton)
        self.betButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.left.equalTo(60.0)
            make.top.equalTo(self.pseudoLabel.snp.bottom).offset(Screen.size.height * 0.05)
        }
        
        // Country button
        self.countryButton.addTarget(self, action: #selector(continueToCountries), for: .touchUpInside)
        self.view.addSubview(self.countryButton)
        self.countryButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.right.equalTo(-50.0)
            make.top.equalTo(self.pseudoLabel.snp.bottom).offset(Screen.size.height * 0.15)
        }
        
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
    
    // Firebase
    func configureDatabase() {
        self.country = FIRDatabase.database().reference().child("france")
        self.country.observe(.value) { (snapshot) in
            for artists in snapshot.children.allObjects as! [FIRDataSnapshot] {
                //getting values
                let country = artists.value as? [String: AnyObject]
                log.debugMessage("country: \(country)")
                
                
//                //creating artist object with model and fetched values
//                let artist = ArtistModel(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String?)
//
//                //appending it to list
//                self.artistList.append(artist)
            }
        }
    
    }
    
    func addCountry(){

        let countries = ["allemagne", "angleterre", "arabie-saoudite", "argentine", "australie", "belgique", "bresil", "coree-du-sud", "costa-rica", "croatie", "danemark", "egypte", "equateur", "espagne", "france", "iceland", "iran", "japon", "maroc", "mexique", "nigeria", "panama", "peru", "poland", "portugal", "russia", "senegal", "serbie", "suede", "suisse", "tunisie", "uruguay"]

        var rawValue: Any!
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                log.debugMessage("Data: \(jsonResult)")
                let raw = FIRDatabase.database().reference().child("worldcuppops")
                raw.setValue(rawValue)
                
                rawValue = jsonResult
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult as? [Any] {
                    // do stuff
                    log.debugMessage("raw")
                    
                }
            } catch {
                // handle error
            }
        }
        
//        for (index, country) in countries.enumerated() {
//            let raw = FIRDatabase.database().reference().child("country\(index)")
//            let key = raw.childByAutoId().key
//
//            raw.setValue(rawValue)
//        }
        
        self.configureDatabase()
    }
}
