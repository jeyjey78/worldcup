//
//  AddBetViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 10/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Lottie

class AddBetViewController: UIViewController {
    
    var flowDelegate: ProfileFlow?
    var match: Match
    
    fileprivate var animation: LOTAnimationView = LOTAnimationView(name: "confirmation-animation")
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    fileprivate var leftImageView = UIImageView()
    fileprivate var rightImageView = UIImageView()
    fileprivate var leftPenaltyLabel: UILabel!
    fileprivate var rightPenaltyLabel: UILabel!
    fileprivate var homeScore = 0 {
        didSet {
            self.leftLabel.text = "\(self.homeScore)"
        }
    }
    fileprivate var awayScore = 0 {
        didSet {
            self.rightLabel.text = "\(self.awayScore)"
        }
    }
    fileprivate var homePenaltyScore = 0 {
        didSet {
            self.leftPenaltyLabel.text = "\(self.homePenaltyScore)"
        }
    }
    
    fileprivate var awayPenaltyScore = 0 {
        didSet {
            self.rightPenaltyLabel.text = "\(self.awayPenaltyScore)"
        }
    }
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.circularStdBlack(28.0)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Faites vos jeux!"
        return label
    }()
    
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
        label.font = UIFont.circularStdBold(28.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(28.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var penaltyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    fileprivate var warningLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(15.0)
        label.textAlignment = .center
        label.text = "Attention! Tout pari est définitif 😏"
        return label
    }()
    
    fileprivate var betButton: UIButton = {
        let button = UIButton()
        button.setTitle("Valider mon pari", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(20.0)
        button.layer.cornerRadius = 27.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor.white
        return button
    }()
    
    fileprivate var confirmationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Aucun doute, je suis le meilleur", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(14.0)
        button.layer.cornerRadius = 27.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor.white
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    fileprivate var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finalement, je vais changer...", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.circularStdBlack(14.0)
        button.layer.cornerRadius = 27.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor.clear
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
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
        
        // Title Label
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(35.0)
            make.width.equalTo(200.0)
            make.top.equalTo(self.customNavigationBar.snp.bottom).offset(30.0)
        }
        
        // Left
        self.leftImageView.image = UIImage(named: "flag-\(String(describing: self.flowDelegate!.teams[self.match.homeTeam-1].name))")
        self.view.addSubview(self.leftImageView)
        self.leftImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(130.0)
            make.left.equalTo(self.view).offset(30.0)
            if self.match.step != "poule" {
                make.centerY.equalTo(self.view).offset(-80.0)
            }
            else {
                make.centerY.equalTo(self.view).offset(-30.0)
            }
        }
        
        self.leftLabel.text = "\(self.homeScore)"
        self.view.addSubview(self.leftLabel)
        self.leftLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.leftImageView)
            make.height.equalTo(30.0)
            make.width.equalTo(60.0)
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
            make.height.width.equalTo(130.0)
            make.centerY.equalTo(self.leftImageView)
            make.right.equalTo(self.view.snp.right).offset(-30.0)
        }
        
        self.rightLabel.text = "\(self.awayScore)"
        self.view.addSubview(self.rightLabel)
        self.rightLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightImageView)
            make.height.equalTo(30.0)
            make.width.equalTo(60.0)
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
        
        // bet button
        self.betButton.addTarget(self, action: #selector(confirmationAction), for: .touchUpInside)
        self.view.addSubview(self.betButton)
        self.betButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.warningLabel.snp.top).offset(-30.0)
            make.height.equalTo(54.0)
            make.left.equalTo(self.view).offset(50.0)
            make.right.equalTo(self.view.snp.right).offset(-50.0)
        }
        
        self.cancelButton.alpha = 0.0
        self.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        self.view.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.warningLabel.snp.top).offset(-30.0)
            make.height.equalTo(54.0)
            make.left.equalTo(self.view).offset(50.0)
            make.right.equalTo(self.view.snp.right).offset(-50.0)
        }
        
        self.confirmationButton.alpha = 0.0
        self.confirmationButton.addTarget(self, action: #selector(betAction), for: .touchUpInside)
        self.view.addSubview(self.confirmationButton)
        self.confirmationButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.cancelButton.snp.top).offset(-20.0)
            make.height.equalTo(54.0)
            make.left.equalTo(self.view).offset(50.0)
            make.right.equalTo(self.view.snp.right).offset(-50.0)
        }
        
        if self.match.step != "poule" {
            self.penaltyBetView()
        }
        
        self.animation.alpha = 0.0
        self.animation.loopAnimation = true
        self.view.addSubview(self.animation)
        self.animation.snp.makeConstraints({ (make) in
            make.height.width.equalTo(200.0)
            make.centerY.centerX.equalToSuperview()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - View
    func penaltyBetView() {
        self.view.addSubview(self.penaltyView)
        self.penaltyView.snp.makeConstraints { (make) in
            make.height.equalTo(100.0)
            make.width.left.equalToSuperview()
            make.top.equalTo(self.rightLabel.snp.bottom).offset(30.0)
        }
        
        let penaltyLabel = UILabel()
        penaltyLabel.text = "Penalty"
        penaltyLabel.textColor = UIColor.white
        penaltyLabel.font = UIFont.circularStdBlack(20.0)
        penaltyLabel.textAlignment = .center
        self.penaltyView.addSubview(penaltyLabel)
        penaltyLabel.snp.makeConstraints { (make) in
            make.centerX.top.width.equalToSuperview()
            make.height.equalTo(30.0)
        }
        
        // Left
        self.leftPenaltyLabel = UILabel()
        self.leftPenaltyLabel.textColor = UIColor.white
        self.leftPenaltyLabel.font = UIFont.circularStdBold(28.0)
        self.leftPenaltyLabel.textAlignment = .center
        self.leftPenaltyLabel.text = "\(self.homePenaltyScore)"
        self.penaltyView.addSubview(self.leftPenaltyLabel)
        self.leftPenaltyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.leftLabel)
            make.height.equalTo(30.0)
            make.width.equalTo(60.0)
            make.top.equalTo(penaltyLabel.snp.bottom).offset(10.0)
        }
        
        let leftReducebutton = UIButton()
        leftReducebutton.setImage(UIImage(named: "reduce-icon"), for: .normal)
        leftReducebutton.addTarget(self, action: #selector(reducePenaltyLeftAction), for: .touchUpInside)
        self.penaltyView.addSubview(leftReducebutton)
        leftReducebutton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftPenaltyLabel)
            make.width.height.equalTo(30.0)
            make.right.equalTo(self.leftPenaltyLabel.snp.left)
        }
        
        let leftIncreasebutton = UIButton()
        leftIncreasebutton.setImage(UIImage(named: "increase-icon"), for: .normal)
        leftIncreasebutton.addTarget(self, action: #selector(increasePenaltyLeftAction), for: .touchUpInside)
        self.penaltyView.addSubview(leftIncreasebutton)
        leftIncreasebutton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftPenaltyLabel)
            make.width.height.equalTo(30.0)
            make.left.equalTo(self.leftPenaltyLabel.snp.right)
        }
        
        
        // Right
        self.rightPenaltyLabel = UILabel()
        self.rightPenaltyLabel.textColor = UIColor.white
        self.rightPenaltyLabel.font = UIFont.circularStdBold(28.0)
        self.rightPenaltyLabel.textAlignment = .center
        self.rightPenaltyLabel.text = "\(self.awayPenaltyScore)"
        self.penaltyView.addSubview(self.rightPenaltyLabel)
        self.rightPenaltyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightLabel)
            make.height.equalTo(30.0)
            make.width.equalTo(60.0)
            make.top.equalTo(penaltyLabel.snp.bottom).offset(10.0)
        }
        
        let rightReducebutton = UIButton()
        rightReducebutton.setImage(UIImage(named: "reduce-icon"), for: .normal)
        rightReducebutton.addTarget(self, action: #selector(reducePenaltyRightAction), for: .touchUpInside)
        self.penaltyView.addSubview(rightReducebutton)
        rightReducebutton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.rightPenaltyLabel)
            make.width.height.equalTo(30.0)
            make.right.equalTo(self.rightPenaltyLabel.snp.left)
        }
        
        let rightIncreasebutton = UIButton()
        rightIncreasebutton.setImage(UIImage(named: "increase-icon"), for: .normal)
        rightIncreasebutton.addTarget(self, action: #selector(increasePenaltyRightAction), for: .touchUpInside)
        self.penaltyView.addSubview(rightIncreasebutton)
        rightIncreasebutton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.rightPenaltyLabel)
            make.width.height.equalTo(30.0)
            make.left.equalTo(self.rightPenaltyLabel.snp.right)
        }
    }
    
    
    //MARK: - Action
    @objc func closeAction() {
        self.flowDelegate?.closeAction()
    }
    
    @objc func increaseLeftAction() {
        self.homeScore += 1
    }
    
    @objc func reduceLeftAction() {
        if self.homeScore - 1 >= 0 {
            self.homeScore -= 1
        }
    }
    
    @objc func increaseRightAction() {
        self.awayScore += 1
    }
    
    @objc func reduceRightAction() {
        if self.awayScore - 1 >= 0 {
            self.awayScore -= 1
        }
    }
    
    @objc func increasePenaltyLeftAction() {
        self.homePenaltyScore += 1
    }
    
    @objc func reducePenaltyLeftAction() {
        if self.homePenaltyScore - 1 >= 0 {
            self.homePenaltyScore -= 1
        }
    }
    
    @objc func increasePenaltyRightAction() {
        self.awayPenaltyScore += 1
    }
    
    @objc func reducePenaltyRightAction() {
        if self.awayPenaltyScore - 1 >= 0 {
            self.awayPenaltyScore -= 1
        }
    }
    
    @objc func betAction() {
        let defaults = UserDefaults.standard
        guard let userId = defaults.object(forKey: Constants.firebaseId) as? String else {
            self.warningLabel.text = "Identifiant non trouvé... Reconnectez-vous 😅"
            return
        }

        let value = [
            "user_id": userId,
            "home_team": self.match.homeTeam,
            "home_score" : self.homeScore,
            "home_pen": self.homePenaltyScore,
            "away_team": self.match.awayTeam,
            "away_score": self.awayScore,
            "away_pen" : self.awayPenaltyScore
            ] as [String : Any]
        
        
        let raw = FIRDatabase.database().reference().child("bets").childByAutoId()
        raw.setValue(value) { (error, ref) in
            if error != nil {
                self.warningLabel.text = "Une erreure est survenue... 😅 Internet?"
                print(error?.localizedDescription ?? "Failed to update value")
            } else {
                self.flowDelegate?.closeAction()
                print("Success update newValue to database")
            }
        }
    }

    
    // MARK: - Animation
    @objc func confirmationAction () {
        self.titleLabel.text = "Êtes-vous sur de votre pari ?"
        UIView.animate(withDuration: 0.3, animations: {
            self.leftImageView.alpha = 0.0
            self.leftLabel.alpha = 0.0
            self.increaseLeftButton.alpha = 0.0
            self.reduceLeftButton.alpha = 0.0
            
            self.rightImageView.alpha = 0.0
            self.rightLabel.alpha = 0.0
            self.increaseRightButton.alpha = 0.0
            self.reduceRightButton.alpha = 0.0
            
            self.penaltyView.alpha = 0.0
            self.betButton.alpha = 0.0

            
        }) { (finished) in
            UIView.animate(withDuration: 0.3, animations: {
                self.animation.alpha = 1.0
                self.cancelButton.alpha = 1.0
                self.confirmationButton.alpha = 1.0
            }) { (finished) in
                self.animation.play()
            }
        }
    }
    
    @objc func cancelAction() {
        self.titleLabel.text = "Faites vos jeux!"
        UIView.animate(withDuration: 0.3, animations: {
            self.animation.alpha = 0.0
            self.cancelButton.alpha = 0.0
            self.confirmationButton.alpha = 0.0

        }) { (finished) in
            self.animation.pause()
            
            UIView.animate(withDuration: 0.3, animations: {
                self.leftImageView.alpha = 1.0
                self.leftLabel.alpha = 1.0
                self.increaseLeftButton.alpha = 1.0
                self.reduceLeftButton.alpha = 1.0
                
                self.rightImageView.alpha = 1.0
                self.rightLabel.alpha = 1.0
                self.increaseRightButton.alpha = 1.0
                self.reduceRightButton.alpha = 1.0
                
                self.penaltyView.alpha = 1.0
                self.betButton.alpha = 1.0
            }) { (finished) in
                
            }
        }
    }
}
