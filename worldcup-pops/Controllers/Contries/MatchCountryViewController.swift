//
//  MatchCountryViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 29/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MatchCountryViewController: UIViewController {
    
    var flowDelegate: ProfileFlow?
    var countryDB: FIRDatabaseReference!
    var countryId: Int
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var countryImageView = UIImageView()
    fileprivate var customNavigationBar = NavigationBar()
    fileprivate var headerTitle = ["Poules", "1/8ème de finale", "1/4 de finale", "1/2 finale", "Finale"]
    fileprivate var matches: [Match] = []
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.register(MatchCountryTableViewCell.self, forCellReuseIdentifier: MatchCountryTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 80.0, right: 0.0)
        return tableView
    }()
    
    
    // MARK: - Life cycle
    init(_ country: Int) {
        self.countryId = country
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        self.getAllMatch()
        
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
        
        self.customNavigationBar.topItem?.title = self.flowDelegate?.teams[self.countryId-1].name
        
        // country imageView
        self.countryImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.countryId-1].name))")
        self.view.addSubview(self.countryImageView)
        self.countryImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100.0)
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(20.0)
        }
        
        // TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.countryImageView.snp.bottom).offset(20.0)
            make.width.left.equalToSuperview()
            make.height.equalTo(Screen.size.height - 140.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Back
    @objc func backAction() {
        self.flowDelegate?.backAction(self)
    }
    
    // MARK: - Action
    func getAllMatch() {
        for match in self.flowDelegate!.matchs {
            if match.awayTeam == self.countryId {
                self.matches.append(match)
            }
            else if match.homeTeam == self.countryId {
                self.matches.append(match)
            }
        }
    }
    
}


// MARK: - UITableView Data Source
extension MatchCountryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchCountryTableViewCell.identifier) as! MatchCountryTableViewCell
        var index = 0
        if indexPath.section == 0 {
            index = indexPath.row
        }
        else {
            index = 2 + indexPath.section
        }
        if index < self.matches.count {
            cell.leftLabel.text = self.flowDelegate?.teams[self.matches[index].homeTeam - 1].name ?? ""
            cell.rightLabel.text = self.flowDelegate?.teams[self.matches[index].awayTeam - 1].name ?? ""
            
            
            if let homeScore = self.matches[index].homeScore, let awayScore = self.matches[index].awayScore {
                cell.scoreLabel.text = "\(homeScore) - \(awayScore)"
            }
            else {
                cell.scoreLabel.text = "-"
            }
        }
        else {
            cell.leftLabel.text = "-"
            cell.rightLabel.text = "-"
            cell.scoreLabel.text = "-"
        }
        
        return cell
    }
    
}


// MARK: - UITableView Delegate
extension MatchCountryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.headerTitle[section]
//    }
//
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = self.headerTitle[section]
        label.font = UIFont.circularStdBook(14.0)
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(20.0)
            make.height.equalTo(15.0)
            make.width.equalToSuperview()
        }
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var index = 0
        if indexPath.section == 0 {
            index = indexPath.row
        }
        else {
            index = 2 + indexPath.section
        }
        
        if index < self.matches.count {
            self.flowDelegate?.continueToMatch(self, match: self.matches[index])
        }
    }
}
