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
    fileprivate var bets: [Bet] = []
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.register(BetTableViewCell.self, forCellReuseIdentifier: BetTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: -35.0, left: 0.0, bottom: 100.0, right: 0.0)
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

        self.getAllBets()
        
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
        
        self.customNavigationBar.topItem?.title = "Tous mes paris"
        
        // TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(20.0)
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
    
    
    // MARK: - Action
    func getAllBets() {
        self.bets = []
        for bet in self.flowDelegate!.bets {
            if bet.userid == self.flowDelegate!.userId {
                self.bets.append(bet)
            }
        }
        self.bets = self.bets.sorted(by: { $0.date > $1.date })
        
        for bet in self.bets {
            log.debugMessage("bet.date: \(bet.date)")
        }
    }
}


// MARK: - UITableView Data Source
extension BetViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BetTableViewCell.identifier) as! BetTableViewCell
        cell.leftLabel.text = self.flowDelegate?.teams[self.bets[indexPath.row].homeTeam - 1].name ?? ""
        cell.rightLabel.text = self.flowDelegate?.teams[self.bets[indexPath.row].awayTeam - 1].name ?? ""
        cell.leftImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.bets[indexPath.row].homeTeam - 1].name))")
        cell.rightImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.bets[indexPath.row].awayTeam - 1].name))")
        
        if let awayPen = self.bets[indexPath.row].awayPen, let homePen = self.bets[indexPath.row].homePen {
            cell.scoreLabel.attributedText = String().customTextAttributes("\(self.bets[indexPath.row].homeScore) - \(self.bets[indexPath.row].awayScore)", "\nPen: \(homePen) - \(awayPen)")
        }
        else {
            cell.scoreLabel.text = "\(self.bets[indexPath.row].homeScore) - \(self.bets[indexPath.row].awayScore)"
        }
        

        
        for match in self.flowDelegate!.matchs {
            if match.homeTeam == self.bets[indexPath.row].homeTeam && match.awayTeam == self.bets[indexPath.row].awayTeam {
                if let matchHomeScore = match.homeScore, let matchAwayScore = match.awayScore {
                    let awayPenalty = match.awayPen == nil ? 0 : match.awayPen
                    let homePenalty = match.homePen == nil ? 0 : match.homePen
                    let awayBetPenalty = self.bets[indexPath.row].awayPen == nil ? 0 : self.bets[indexPath.row].awayPen
                    let homeBetPenalty = self.bets[indexPath.row].homePen == nil ? 0 : self.bets[indexPath.row].homePen
                    log.debugMessage("score: \(matchHomeScore + homePenalty!) - \(matchAwayScore + awayPenalty!) //// \(self.bets[indexPath.row].homeScore + homeBetPenalty!) - \(self.bets[indexPath.row].awayScore + awayBetPenalty!)")
                    if  matchHomeScore + homePenalty! == self.bets[indexPath.row].homeScore + homeBetPenalty! && matchAwayScore + awayPenalty! == self.bets[indexPath.row].awayScore + awayBetPenalty! {
                        cell.status = .total
                    }
                    else if (matchHomeScore + homePenalty! > matchAwayScore + awayPenalty! && self.bets[indexPath.row].homeScore + homeBetPenalty! > self.bets[indexPath.row].awayScore + awayBetPenalty!) ||
                        (matchHomeScore + homePenalty! < matchAwayScore + awayPenalty! && self.bets[indexPath.row].homeScore + homeBetPenalty! < self.bets[indexPath.row].awayScore + awayBetPenalty!) ||
                        (matchHomeScore + homePenalty! == matchAwayScore + awayPenalty! && self.bets[indexPath.row].homeScore + homeBetPenalty! == self.bets[indexPath.row].awayScore + awayBetPenalty!) {
                        cell.status = .win
                    }
                    else {
                        cell.status = .lose
                    }
                }
            }
        }
        

        
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

        return BetTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //self.flowDelegate?.continueToMatch(self, match: )
    }
}
