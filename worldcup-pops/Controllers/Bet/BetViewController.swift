//
//  BetViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 24/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class BetViewController: UIViewController {
    
    var flowDelegate: ProfileFlow?
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.register(BetTableViewCell.self, forCellReuseIdentifier: BetTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: -35.0, left: 0.0, bottom: 80.0, right: 0.0)
        return tableView
    }()
    
    fileprivate var winLabel: UILabel = {
        let label = UILabel()
        label.text = "Winner 2"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(18.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var loseLabel: UILabel = {
        let label = UILabel()
        label.text = "Loser 5"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(18.0)
        label.textAlignment = .center
        return label
    }()
    
    // Liste de mes parris (vainqueur-looser et score)

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
        
        let backBarButton = UIBarButtonItem(image: UIImage(named: "back-white-icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(backProfile))
        backBarButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0.0, right: 0.0)
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = backBarButton
        self.customNavigationBar.pushItem(navigationItem, animated: true)
        
        self.customNavigationBar.topItem?.title = "Bet"
        
        // Win label
        self.view.addSubview(self.winLabel)
        self.winLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(20.0)
            make.height.equalTo(20.0)
            make.width.equalTo(120.0)
            make.left.equalTo(self.view).offset(20.0)
        }
        
        // Lose label
        self.view.addSubview(self.loseLabel)
        self.loseLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.winLabel)
            make.height.equalTo(20.0)
            make.width.equalTo(120.0)
            make.right.equalTo(self.view.snp.right).offset(-20.0)
        }
        
        // TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.winLabel.snp.bottom).offset(20.0)
            make.height.width.left.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Back
    @objc func backProfile() {
        self.flowDelegate?.backProfile(self)
    }
}


// MARK: - UITableView Data Source
extension BetViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BetTableViewCell.identifier) as! BetTableViewCell
        
        return cell
    }
}


// MARK: - UITableView Delegate
extension BetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //self.flowDelegate?.continueToMatch(self, match: )
    }
}
