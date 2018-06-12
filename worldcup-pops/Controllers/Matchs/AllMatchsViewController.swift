//
//  AllMatchsViewController.swift
//  worldcup-pops
//
//  Created by Jérémy GROS on 12/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class AllMatchsViewController: UIViewController {

    var flowDelegate: ProfileFlow?
    var matchs: [Match] = []
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    
    fileprivate var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdMedium(20.0)
        label.textAlignment = .center
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.register(AllMatchTableViewCell.self, forCellReuseIdentifier: AllMatchTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: -35.0, left: 0.0, bottom: 80.0, right: 0.0)
        return tableView
    }()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        self.getDayMatchs()
        
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
        
        self.customNavigationBar.topItem?.title = "Les matchs du jour"
        
        //date
        self.dateLabel.text = "\(Date().toString(dateFormat: "dd MMM yyyy"))"
        self.view.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(10.0)
            make.height.equalTo(50.0)
        }
        
        // TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(20.0)
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
    
    
    // MARK: - Actions
    func getDayMatchs() {
        for match in self.flowDelegate!.matchs {
            if match.date.toString(dateFormat: "dd MMM yyyy") == Date().toString(dateFormat: "dd MMM yyyy") {
                self.matchs.append(match)
            }
        }
        
        self.matchs = self.matchs.sorted(by: { $0.date < $1.date })
    }
}


// MARK: - UITableView Data Source
extension AllMatchsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.matchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllMatchTableViewCell.identifier) as! AllMatchTableViewCell
        cell.leftLabel.text = self.flowDelegate?.teams[self.matchs[indexPath.row].homeTeam - 1].name ?? ""
        cell.rightLabel.text = self.flowDelegate?.teams[self.matchs[indexPath.row].awayTeam - 1].name ?? ""
        cell.leftImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.matchs[indexPath.row].homeTeam - 1].name))")
        cell.rightImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.matchs[indexPath.row].awayTeam - 1].name))")
        
        var step = ""
        if self.matchs[indexPath.row].step == "poule" {
            step = "groupe \(self.matchs[indexPath.row].group)"
        }
        else {
            switch self.matchs[indexPath.row].step {
            case "round_16":
                step = "1/8ème"
            case "round_8":
                step = "quart"
            case "round_4":
                step = "demi"
            case "round_2":
                step = "finale"
            case "round_2_loser":
                step = "petite\nfinale"
            default:
                step = ""
            }
        }
        
        cell.scoreLabel.attributedText = String().customTextAttributes(self.matchs[indexPath.row].date.toString(dateFormat: "HH:mm"), "\n" + step)
        return cell
    }
}


// MARK: - UITableView Delegate
extension AllMatchsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return AllMatchTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.flowDelegate?.continueToMatch(self, match: self.matchs[indexPath.row])
    }
}
