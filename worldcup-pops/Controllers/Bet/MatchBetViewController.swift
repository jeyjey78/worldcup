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
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    fileprivate var leftImageView = UIImageView()
    fileprivate var rightImageView = UIImageView()
    
    fileprivate var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(32.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(17.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(17.0)
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
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 27.0, bottom: 0.0, right: 27.0)
        layout.itemSize = MatchBetCollectionViewCell.size
        layout.minimumInteritemSpacing = 17.0
        return layout
    }()
    
    private var collectionView: UICollectionView = {
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
            make.left.equalTo(self.view).offset(40.0)
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
            self.scoreLabel.text = "\(homeScore) - \(awayScore)"
        }
        else {
            self.scoreLabel.text = "-"
        }
        self.view.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftImageView)
            make.height.equalTo(30.0)
            make.width.equalTo(70.0)
            make.centerX.equalTo(self.view)
        }
        
        // loser
        self.rightImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.match.awayTeam-1].name))")
        self.view.addSubview(self.rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100.0)
            make.centerY.equalTo(self.leftImageView)
            make.right.equalTo(self.view.snp.right).offset(-40.0)
        }
        
        self.rightLabel.text = self.flowDelegate?.teams[self.match.awayTeam - 1].name ?? ""
        self.view.addSubview(self.rightLabel)
        self.rightLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightImageView)
            make.height.equalTo(20.0)
            make.width.equalTo(150.0)
            make.top.equalTo(self.rightImageView.snp.bottom).offset(4.0)
        }
        
        // Bet button
        self.betButton.addTarget(self, action: #selector(betAction), for: .touchUpInside)
        self.view.addSubview(self.betButton)
        self.betButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.leftLabel.snp.bottom).offset(40.0)
            make.height.equalTo(54.0)
            make.width.equalTo(250.0)
        }
        
        // Collection View
        self.collectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.betButton.snp.bottom).offset(20.0)
            make.width.left.equalToSuperview()
            make.height.equalTo(Screen.size.height/2)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchBetCollectionViewCell.identifier, for: indexPath) as! MatchBetCollectionViewCell
        
        return cell
    }
}


// MARK: - UICollectionView Delegate
extension MatchBetViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}
