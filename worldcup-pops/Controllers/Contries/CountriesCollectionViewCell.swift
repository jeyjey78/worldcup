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
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
}
