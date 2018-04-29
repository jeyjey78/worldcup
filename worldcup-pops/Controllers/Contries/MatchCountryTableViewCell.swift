//
//  MatchCountryTableViewCell.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 29/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class MatchCountryTableViewCell: UITableViewCell {

    static let identifier = "MatchCountryTableViewCell"
    static let height: CGFloat = 80.0
    
    fileprivate var winLabel: UILabel = {
        let label = UILabel()
        label.text = "France"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(17.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var loseLabel: UILabel = {
        let label = UILabel()
        label.text = "Espagne"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(17.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "2 - 0"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdMedium(21.0)
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
        
        // Win label
        self.addSubview(self.winLabel)
        self.winLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30.0)
            make.height.equalTo(20.0)
            make.width.equalTo(proportionalWidth)
            make.left.equalTo(self)
        }
        
        // Lose label
        self.addSubview(self.loseLabel)
        self.loseLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.winLabel)
            make.height.equalTo(20.0)
            make.width.equalTo(proportionalWidth)
            make.left.equalTo(self.winLabel.snp.right)
        }
        
        // Score label
        self.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.winLabel)
            make.height.equalTo(25.0)
            make.width.equalTo(50.0)
            make.left.equalTo(self.winLabel.snp.right).offset(-25.0)
        }
        
        self.addSubview(self.separator)
        self.separator.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.0)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(1.0)
        }
    }

}
