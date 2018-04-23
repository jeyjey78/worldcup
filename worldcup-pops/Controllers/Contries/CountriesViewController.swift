//
//  CountriesViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 24/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    static var itemSize: CGSize {
        let width = (Screen.size.width - 24) / 3
        let height = round(width * 1.35)
        
        return CGSize(width: width, height: height)
    }
    
    var collectionView: UICollectionView?
    var collectionViewFlowLayout: UICollectionViewFlowLayout?
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // CollectionView
        self.collectionViewFlowLayout = UICollectionViewFlowLayout()
        self.collectionViewFlowLayout?.itemSize = CountriesViewController.itemSize
        self.collectionViewFlowLayout?.minimumInteritemSpacing = 4.0
        self.collectionViewFlowLayout?.minimumLineSpacing = 4.0
        self.collectionViewFlowLayout?.sectionInset = UIEdgeInsets(top: 10.0, left: 8.0, bottom: 78.0, right: 8.0)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.collectionViewFlowLayout!)
        self.collectionView?.register(CountriesCollectionViewCell.self, forCellWithReuseIdentifier: CountriesCollectionViewCell.identifier)
        if #available(iOS 11.0, *) {
            self.collectionView?.contentInsetAdjustmentBehavior = .never
        }
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.allowsMultipleSelection = true
        self.view.addSubview(self.collectionView!)
        self.collectionView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.right.equalTo(self.view)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UICollectionView DataSource
extension CountriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountriesCollectionViewCell.identifier, for: indexPath) as! CountriesCollectionViewCell
        
        
        return cell
    }
}


// MARK: - UICollectionView delegate
extension CountriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}
