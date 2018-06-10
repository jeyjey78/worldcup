//
//  CountriesViewController.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 24/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import Willow

class CountriesViewController: UIViewController {
    
    static var itemSize: CGSize {
        let width = (Screen.size.width - 24) / 3
        let height = round(width * 1.35)
        
        return CGSize(width: width, height: height)
    }
    
    var countries = ["allemagne", "angleterre", "arabie-saoudite", "argentine", "australie", "belgique", "bresil", "coree-du-sud", "costa-rica", "croatie", "danemark", "egypte", "equateur", "espagne", "france", "iran", "islande", "japon", "maroc", "mexique", "nigeria", "panama", "perou", "pologne", "portugal", "russie", "senegal", "serbie", "suede", "suisse", "tunisie", "uruguay"]
    
    var flowDelegate: ProfileFlow?
    var collectionView: UICollectionView?
    var collectionViewFlowLayout: UICollectionViewFlowLayout?
    
    fileprivate var backgroundImageView = UIImageView(image: UIImage(named: "background-worldcup"))
    fileprivate var customNavigationBar = NavigationBar()
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.circularStdBlack(20.0)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Pays"
        return label
    }()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let backBarButton = UIBarButtonItem(image: UIImage(named: "back-white-icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(backProfile))
        backBarButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0.0, right: 0.0)
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = backBarButton
        self.customNavigationBar.pushItem(navigationItem, animated: true)
        
        self.customNavigationBar.topItem?.title = "Pays"
        
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
            make.top.equalTo(self.customNavigationBar.snp.bottom)
            make.left.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.right.equalTo(self.view)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Back
    @objc func backProfile() {
        self.flowDelegate?.backProfile(self)
    }
}

// MARK: - UICollectionView DataSource
extension CountriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountriesCollectionViewCell.identifier, for: indexPath) as! CountriesCollectionViewCell
        cell.image = UIImage(named: "flag-\(self.countries[indexPath.row])")!
        
        return cell
    }
}


// MARK: - UICollectionView delegate
extension CountriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for team in self.flowDelegate!.teams {
            log.debugMessage("id : \(team.id) - \(team.name) ")
            if team.name == self.countries[indexPath.row] {
                self.flowDelegate?.continueToMatchCountry(self, countryId: team.id)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}
