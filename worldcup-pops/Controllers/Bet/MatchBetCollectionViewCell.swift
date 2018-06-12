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
    static let size: CGSize = UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? CGSize(width: 150.0, height: 150.0) :  CGSize(width: 220.0, height: 220.0)
    
    fileprivate var iconImageView = UIImageView(image: UIImage(named: "win-icon"))
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-bet"))
    var flagImageView = UIImageView(image: UIImage(named: "flag-france"))
    
    var pseudoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBlack( UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 17.0 : 27.0)
        label.textAlignment = .center
        return label
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 24.0 : 36.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var shadowGradient: CAGradientLayer = {
        let top = UIColor.black.withAlphaComponent(0.3).cgColor
        let bottom = UIColor.black.withAlphaComponent(0.1).cgColor
        
        let layer = CAGradientLayer()
        layer.colors = [top, bottom]
        layer.locations = [0.0, 1.0]
        layer.frame = CGRect(origin: .zero, size: MatchBetCollectionViewCell.size)
        layer.cornerRadius = 15.0
        return layer
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
        
        self.flagImageView.image = nil
        self.pseudoLabel.text = nil
        self.scoreLabel.text = nil
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
        self.backgroundImageView.layer.addSublayer(self.shadowGradient)
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // Pseudo
        self.addSubview(self.pseudoLabel)
        self.pseudoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 20.0 : 30.0)
            make.width.equalToSuperview()
            make.top.equalTo(self).offset(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 10.0 : 20.0)
        }
        
        //Flag
        self.addSubview(self.flagImageView)
        self.flagImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 50.0 : 70.0)
            make.top.equalTo(self.pseudoLabel.snp.bottom).offset(20.0)
        }
        
        // Score
        self.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 60.0 : 70.0)
            make.top.equalTo(self.flagImageView.snp.bottom)//.offset( UIDevice().type == .iPhone5 || UIDevice().type == .iPhoneSE ? 0.0 : 0.0)
        }
    }
}
