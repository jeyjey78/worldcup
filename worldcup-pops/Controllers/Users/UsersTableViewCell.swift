//
//  UsersTableViewCell.swift
//  worldcup-pops
//
//  Created by Jérémy GROS on 13/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    static let identifier = "UsersTableViewCell"
    static let height: CGFloat = 70.0
    
    var leftImageView = UIImageView()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdMedium(20.0)
        label.textAlignment = .left
        return label
    }()
    
    var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.circularStdBold(32.0)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.leftImageView.image = nil
        self.nameLabel.text = nil
        self.pointsLabel.text = nil
    }
    
    
    // MARK: - View
    func configureView() {
        let proportionalWidth: CGFloat = Screen.size.width / 2
        
        // Win label
        self.addSubview(self.leftImageView)
        self.leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10.0)
            make.top.equalTo(self).offset(15.0)
            make.height.width.equalTo(40.0)
        }
        
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25.0)
            make.width.equalTo(proportionalWidth)
            make.left.equalTo(self.leftImageView.snp.right).offset(10.0)
            make.centerY.equalTo(self.leftImageView)
        }
        
        self.addSubview(self.pointsLabel)
        self.pointsLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-20.0)
            make.height.equalTo(50.0)
            make.width.equalTo(70.0)
            make.centerY.equalTo(self.leftImageView)
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
