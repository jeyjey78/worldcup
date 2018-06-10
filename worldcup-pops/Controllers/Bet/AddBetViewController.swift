//
//  AddBetViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 10/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class AddBetViewController: UIViewController {
    
    var flowDelegate: ProfileFlow?
    var match: Match
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    fileprivate var leftImageView = UIImageView()
    fileprivate var rightImageView = UIImageView()
    fileprivate var homeScore = 0
    fileprivate var awayScore = 0
    
    fileprivate var increaseLeftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "increase-icon"), for: .normal)
        button.addTarget(self, action: #selector(increaseLeftAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate var increaseRightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "increase-icon"), for: .normal)
        button.addTarget(self, action: #selector(increaseRightAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate var reduceLeftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reduce-icon"), for: .normal)
        button.addTarget(self, action: #selector(reduceLeftAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate var reduceRightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reduce-icon"), for: .normal)
        button.addTarget(self, action: #selector(reduceRightAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(24.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(24.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var warningLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(15.0)
        label.textAlignment = .center
        label.text = "Attention! Tout pari est définitif 😏"
        return label
    }()
    
    
    // MARK: - Life cycle
    init(_ match: Match) {
        self.match = match
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        
        // Background
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // navigationBar
        self.view.addSubview(self.customNavigationBar)
        self.customNavigationBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.height.equalTo(UIDevice.current.type == UIDevice.DeviceType.iPhoneX ? 88.0 : 64.0)
        }
        
        let backBarButton = UIBarButtonItem(image: UIImage(named: "close-icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(closeAction))
        backBarButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0.0, right: 0.0)
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = backBarButton
        self.customNavigationBar.pushItem(navigationItem, animated: true)
        
        self.customNavigationBar.topItem?.title = "Votre pari"
        
        // Left
        self.leftImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.match.homeTeam-1].name))")
        self.view.addSubview(self.leftImageView)
        self.leftImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.left.equalTo(self.view).offset(40.0)
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(20.0)
        }
        
        self.leftLabel.text = "\(self.homeScore)"
        self.view.addSubview(self.leftLabel)
        self.leftLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.leftImageView)
            make.height.equalTo(20.0)
            make.width.equalTo(50.0)
            make.top.equalTo(self.leftImageView.snp.bottom).offset(15.0)
        }
        
        self.view.addSubview(self.reduceLeftButton)
        self.reduceLeftButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftLabel)
            make.width.height.equalTo(30.0)
            make.right.equalTo(self.leftLabel.snp.left)
        }
        
        self.view.addSubview(self.increaseLeftButton)
        self.increaseLeftButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftLabel)
            make.width.height.equalTo(30.0)
            make.left.equalTo(self.leftLabel.snp.right)
        }
        
        // right
        self.rightImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.match.awayTeam-1].name))")
        self.view.addSubview(self.rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.centerY.equalTo(self.leftImageView)
            make.right.equalTo(self.view.snp.right).offset(-40.0)
        }
        
        self.rightLabel.text = "\(self.awayScore)"
        self.view.addSubview(self.rightLabel)
        self.rightLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightImageView)
            make.height.equalTo(20.0)
            make.width.equalTo(50.0)
            make.top.equalTo(self.rightImageView.snp.bottom).offset(15.0)
        }
        
        self.view.addSubview(self.reduceRightButton)
        self.reduceRightButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.rightLabel)
            make.width.height.equalTo(30.0)
            make.right.equalTo(self.rightLabel.snp.left)
        }
        
        self.view.addSubview(self.increaseRightButton)
        self.increaseRightButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.rightLabel)
            make.width.height.equalTo(30.0)
            make.left.equalTo(self.rightLabel.snp.right)
        }
        
        // warning label
        self.view.addSubview(self.warningLabel)
        self.warningLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30.0)
            make.height.equalTo(20.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Action
    @objc func closeAction() {
        self.flowDelegate?.closeAction()
    }
    
    @objc func increaseLeftAction() {
        
    }
    
    @objc func increaseRightAction() {
        
    }
    
    @objc func reduceLeftAction() {
        
    }
    
    @objc func reduceRightAction() {
        
    }

}
