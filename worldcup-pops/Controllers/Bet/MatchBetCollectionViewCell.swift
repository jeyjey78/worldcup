//
//  MatchBetCollectionViewCell.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 01/05/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class MatchBetCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MatchBetTableViewCell"
    static let size: CGSize = CGSize(width: 220.0, height: 220.0)
    
    fileprivate var iconImageView = UIImageView(image: UIImage(named: "win-icon"))
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-bet"))
    fileprivate var flagImageView = UIImageView(image: UIImage(named: "flag-france"))
    
    fileprivate var pseudoLabel: UILabel = {
        let label = UILabel()
        label.text = "Jeyjey"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBlack(27.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "2 - 0"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(36.0)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - View
    func configureView() {
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 15.0
        self.layer.cornerRadius = 16.0
        
        // background
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // Pseudo
        self.addSubview(self.pseudoLabel)
        self.pseudoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(30.0)
            make.width.equalToSuperview()
            make.top.equalTo(self).offset(20.0)
        }
        
        //Flag
        self.addSubview(self.flagImageView)
        self.flagImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70.0)
            make.top.equalTo(self.pseudoLabel.snp.bottom).offset(20.0)
        }
        
        // Score
        self.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(40.0)
            make.top.equalTo(self.flagImageView.snp.bottom).offset(20.0)
        }
    }
}
