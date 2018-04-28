//
//  MatchBetViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 27/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class MatchBetViewController: UIViewController {
    
    var flowDelegate: ProfileFlow?
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    fileprivate var winnerImageView = UIImageView(image: UIImage(named: "flag-france"))
    fileprivate var loserImageView = UIImageView(image: UIImage(named: "flag-espagne"))
    
    fileprivate var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "2 - 0"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(32.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var betButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bet", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(24.0)
        button.layer.cornerRadius = 27.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.register(MatchBetTableViewCell.self, forCellReuseIdentifier: MatchBetTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: -35.0, left: 0.0, bottom: 80.0, right: 0.0)
        return tableView
    }()
    
    
    // MARK: - Life cycle
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
        
        let backBarButton = UIBarButtonItem(image: UIImage(named: "back-white-icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(backAction))
        backBarButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0.0, right: 0.0)
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = backBarButton
        self.customNavigationBar.pushItem(navigationItem, animated: true)
        
        self.customNavigationBar.topItem?.title = "Match"
        
        // winner
        self.view.addSubview(self.winnerImageView)
        self.winnerImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.left.equalTo(self.view).offset(40.0)
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(30.0)
        }
        
        // score
        self.view.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.winnerImageView)
            make.height.equalTo(30.0)
            make.width.equalTo(70.0)
            make.centerX.equalTo(self.view)
        }
        
        // loser
        self.view.addSubview(self.loserImageView)
        self.loserImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.centerY.equalTo(self.winnerImageView)
            make.right.equalTo(self.view.snp.right).offset(-40.0)
        }
        
        // Bet button
        self.view.addSubview(self.betButton)
        self.betButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.winnerImageView.snp.bottom).offset(20.0)
            make.height.equalTo(54.0)
            make.width.equalTo(250.0)
        }
        
        // TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //self.tableView.tableHeaderView = self.headerView
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.betButton.snp.bottom).offset(20.0)
            make.height.width.left.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @objc func backAction() {
        self.flowDelegate?.backAction(self)
    }
}

// MARK: - UITableView Data Source
extension MatchBetViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchBetTableViewCell.identifier) as! MatchBetTableViewCell
        
        return cell
    }
}


// MARK: - UITableView Delegate
extension MatchBetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return MatchBetTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
