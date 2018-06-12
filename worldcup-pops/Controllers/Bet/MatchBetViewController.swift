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
    var match: Match
    var bets: [Bet] = []
    var alreadyBet = false
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    fileprivate var leftImageView = UIImageView()
    fileprivate var rightImageView = UIImageView()
    
    fileprivate var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(32.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdMedium(20.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var stadiumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdMedium(14.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdMedium(17.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdMedium(17.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var betButton: UIButton = {
        let button = UIButton()
        button.setTitle("Parier 💸", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(24.0)
        button.layer.cornerRadius = 27.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor.white
        return button
    }()
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 40.0, bottom: 0.0, right: 40.0)
        layout.itemSize = MatchBetCollectionViewCell.size
        layout.minimumInteritemSpacing = 25.0
        return layout
    }()
    
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MatchBetCollectionViewCell.self, forCellWithReuseIdentifier: MatchBetCollectionViewCell.identifier)
        return collectionView
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
        
        self.loadBets()
        
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
        self.leftImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.match.homeTeam-1].name))")
        self.view.addSubview(self.leftImageView)
        self.leftImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.left.equalTo(self.view).offset(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 20.0 : 40.0)
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(20.0)
        }
        
        self.leftLabel.text = self.flowDelegate?.teams[self.match.homeTeam - 1].name ?? ""
        self.view.addSubview(self.leftLabel)
        self.leftLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.leftImageView)
            make.height.equalTo(20.0)
            make.width.equalTo(150.0)
            make.top.equalTo(self.leftImageView.snp.bottom).offset(4.0)
        }
        
        // score
        if let homeScore = self.match.homeScore, let awayScore = self.match.awayScore {
            let score = "\(homeScore) - \(awayScore)"
            if let homePen = self.match.homePen, let awayPen = self.match.awayPen {
                let startAttribute = NSMutableAttributedString(string: score, attributes: [NSAttributedStringKey.font : UIFont.circularStdBold(32.0), NSAttributedStringKey.foregroundColor : UIColor.white])
                let endAttribute = NSMutableAttributedString(string: "\nPen: \(homePen) - \(awayPen)", attributes: [NSAttributedStringKey.font : UIFont.circularStdBook(14.0), NSAttributedStringKey.foregroundColor : UIColor.white])
                
                startAttribute.append(endAttribute)
                self.scoreLabel.attributedText = startAttribute
            }
            else {
                self.scoreLabel.text = score
            }
            
        }
        else {
            self.scoreLabel.text = "-"
        }
        
        self.view.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftImageView)
            make.height.equalTo(90.0)
            make.width.equalTo(70.0)
            make.centerX.equalTo(self.view)
        }
        
        // loser
        self.rightImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.match.awayTeam-1].name))")
        self.view.addSubview(self.rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.centerY.equalTo(self.leftImageView)
            make.right.equalTo(self.view.snp.right).offset(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? -20.0 : -40.0)
        }
        
        self.rightLabel.text = self.flowDelegate?.teams[self.match.awayTeam - 1].name ?? ""
        self.view.addSubview(self.rightLabel)
        self.rightLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightImageView)
            make.height.equalTo(20.0)
            make.width.equalTo(150.0)
            make.top.equalTo(self.rightImageView.snp.bottom).offset(4.0)
        }
        
        // Date label
        self.dateLabel.text = self.match.date.toString(dateFormat: "dd MMM yyyy - HH:mm")
        self.view.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(30.0)
            make.top.equalTo(self.leftLabel.snp.bottom).offset(20.0)
        }
        
        // Stadium label
        self.stadiumLabel.adjustsFontSizeToFitWidth = true
        self.stadiumLabel.text = self.flowDelegate!.stadiums[self.match.stadium! - 1].name  + " - " + self.flowDelegate!.stadiums[self.match.stadium! - 1].city
        self.view.addSubview(self.stadiumLabel)
        self.stadiumLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(30.0)
            make.top.equalTo(self.dateLabel.snp.bottom)
        }
        
        // Bet button
        if self.alreadyBet {
            self.updateBetButton()
        }
        if self.match.date < Date() {
            self.updateBetButton()
        }
        self.betButton.addTarget(self, action: #selector(betAction), for: .touchUpInside)
        self.view.addSubview(self.betButton)
        self.betButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.leftLabel.snp.bottom).offset(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 90.0 : 110.0)
            make.height.equalTo(54.0)
            make.width.equalTo(250.0)
        }
        
        // Collection View
        self.collectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-30.0)
            make.width.left.equalToSuperview()
            make.height.equalTo(MatchBetCollectionViewCell.size.height + 20.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - View
    func updateBetButton() {
        self.betButton.setTitle("Tous les paris", for: .normal)
        self.betButton.setTitleColor(UIColor.white, for: .normal)
        self.betButton.layer.borderColor = UIColor.clear.cgColor
        self.betButton.backgroundColor = UIColor.clear
        self.betButton.titleLabel?.font = UIFont.circularStdBlack(27.0)
        self.betButton.isEnabled = false
    }
    
    // MARK: - Actions
    func loadBets() {
        self.bets = []
        for bet in self.flowDelegate!.bets {
            if bet.homeTeam == self.match.homeTeam && bet.awayTeam == self.match.awayTeam {
                if bet.userid == self.flowDelegate!.userId {
                    self.alreadyBet = true
                }
                
                self.bets.append(bet)
            }
        }
        
        self.bets = self.bets.sorted(by: { $0.date > $1.date })
    }

    
    @objc func betAction() {
        self.flowDelegate?.continueToAddBet(self, match: self.match)
    }
    
    @objc func backAction() {
        self.flowDelegate?.backAction(self)
    }
}


// MARK: - UICollectionView Data Source
extension MatchBetViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchBetCollectionViewCell.identifier, for: indexPath) as! MatchBetCollectionViewCell
        cell.pseudoLabel.text = self.bets[indexPath.row].userName
        let awayPenalty = self.bets[indexPath.row].awayPen == nil ? 0 : self.bets[indexPath.row].awayPen
        let homePenalty = self.bets[indexPath.row].homePen == nil ? 0 : self.bets[indexPath.row].homePen
        let winner = self.bets[indexPath.row].awayScore + awayPenalty! > self.bets[indexPath.row].homeScore + homePenalty! ? self.bets[indexPath.row].awayTeam : self.bets[indexPath.row].homeTeam
        cell.flagImageView.image = self.bets[indexPath.row].awayScore + awayPenalty! == self.bets[indexPath.row].homeScore + homePenalty! ? UIImage(named: "flag-egalite") : UIImage(named: "flag-\(self.flowDelegate!.teams[winner-1].name)")
        
        log.debugMessage("homePen \(self.bets[indexPath.row].homePen)")
        if let awayPen = self.bets[indexPath.row].awayPen, let homePen = self.bets[indexPath.row].homePen {
            let startAttribute = NSMutableAttributedString(string: "\(self.bets[indexPath.row].homeScore) - \(self.bets[indexPath.row].awayScore)", attributes: [NSAttributedStringKey.font :UIFont.circularStdBold(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 24.0 : 36.0) , NSAttributedStringKey.foregroundColor : UIColor.white])
            let endAttribute = NSMutableAttributedString(string: "\nPen: \(homePen) - \(awayPen)", attributes: [NSAttributedStringKey.font : UIFont.circularStdBook(12.0), NSAttributedStringKey.foregroundColor : UIColor.white])
            
            startAttribute.append(endAttribute)
            cell.scoreLabel.attributedText = startAttribute
        }
        else {
            cell.scoreLabel.text = "\(self.bets[indexPath.row].homeScore) - \(self.bets[indexPath.row].awayScore)"
        }
        
        return cell
    }
}


// MARK: - UICollectionView Delegate
extension MatchBetViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}
