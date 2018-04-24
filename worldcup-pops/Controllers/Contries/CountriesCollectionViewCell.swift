//
//  CountriesCollectionViewCell.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 24/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class CountriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "countries.cell.identifier"
    
    static var itemSize: CGSize {
        let width = (Screen.size.width - 24) / 3
        let height = round(width * 1.35)
        
        return CGSize(width: width, height: width)
    }
    
    var imageView = UIImageView()
    
    var image = UIImage() {
        didSet {
            self.imageView.image = self.image
        }
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(100.0)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
}
