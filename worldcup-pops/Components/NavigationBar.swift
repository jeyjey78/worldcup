//
//  NavigationBar.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 24/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    // MARK: - Life cycle
    init() {
        super.init(frame: .zero)
        
        self.isTranslucent = true
        self.barTintColor = UIColor.clear
        self.shadowImage = UIImage()//.imageWithColor(UIColor.fffTwoColor(), width: nil, height: 2.0)
        self.setBackgroundImage(UIImage(), for: .default)
        
        if #available(iOS 11.0, *) {
            self.prefersLargeTitles = false
        }
        
        self.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.circularStdBlack(17.0) as Any
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 11.0, *) {
            for view in self.subviews {
                let className = String(describing: type(of: view))
                
                if className == "_UINavigationBarContentView" {
                    let y: CGFloat = UIDevice.current.type == UIDevice.DeviceType.iPhoneX ? 44.0 : 20.0
                    
                    view.frame = CGRect(x: 0.0, y: y, width: view.frame.size.width, height: 44.0)
                }
                else if className == "_UIBarBackground" {
                    let height: CGFloat = UIDevice.current.type == UIDevice.DeviceType.iPhoneX ? 88.0 : 64.0
                    
                    view.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: height)
                }
            }
        }
    }
}
