//
//  MatchBetTableViewCell.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 28/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class MatchBetTableViewCell: UITableViewCell {

    static let identifier = "MatchBetTableViewCell"
    static let height: CGFloat = 60.0
    
    fileprivate var iconImageView = UIImageView(image: UIImage(named: "win-icon"))
    
    fileprivate var pseudoLabel: UILabel = {
        let label = UILabel()
        label.text = "Jeyjey"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBlack(17.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "2 - 0"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(21.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    
    
    // MARK: - Life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View
    func configureView() {
        let proportionalWidth: CGFloat = Screen.size.width / 2
        
        // icon
        self.iconImageView.contentMode = .scaleAspectFit
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10.0)
            make.height.width.equalTo(20.0)
            make.top.equalTo(self).offset(20.0)
        }
        
        // Win label
        self.addSubview(self.pseudoLabel)
        self.pseudoLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.iconImageView)
            make.height.equalTo(20.0)
            make.width.equalTo(proportionalWidth)
            make.left.equalTo(self.iconImageView.snp.right).offset(20.0)
        }
        
        // Score label
        self.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.iconImageView)
            make.height.equalTo(25.0)
            make.width.equalTo(50.0)
            make.right.equalTo(self.snp.right).offset(-24.0)
        }
        
        self.addSubview(self.separator)
        self.separator.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(35.0)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(1.0)
        }
    }
}
