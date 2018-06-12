//
//  BetTableViewCell.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 25/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class BetTableViewCell: UITableViewCell {
    
    static let identifier = "BetTableViewCell"
    static let height: CGFloat = 100.0
    
    var leftImageView = UIImageView()
    var rightImageView = UIImageView()
    
    var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "France"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(17.0)
        label.textAlignment = .center
        return label
    }()
    
    var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Espagne"
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBook(17.0)
        label.textAlignment = .center
        return label
    }()
    
    var scoreLabel: UILabel = {
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
        self.addSubview(self.leftImageView)
        self.leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(Screen.size.width * 0.17)
            make.top.equalTo(self).offset(10.0)
            make.height.width.equalTo(50.0)
        }
        
        self.addSubview(self.leftLabel)
        self.leftLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.leftImageView.snp.bottom).offset(3.0)
            make.height.equalTo(20.0)
            make.width.equalTo(proportionalWidth)
            make.centerX.equalTo(self.leftImageView)
        }
        
        // Lose label
        self.rightImageView.contentMode = .scaleAspectFill
        self.addSubview(self.rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-(Screen.size.width * 0.17))
            make.top.equalTo(self).offset(10.0)
            make.height.width.equalTo(50.0)
        }
        
        self.addSubview(self.rightLabel)
        self.rightLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftLabel)
            make.height.equalTo(20.0)
            make.width.equalTo(proportionalWidth)
            make.centerX.equalTo(self.rightImageView)
        }
        
        // Score label
        self.addSubview(self.scoreLabel)
        self.scoreLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25.0)
            make.width.equalTo(70.0)
            make.centerX.centerY.equalToSuperview()
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
