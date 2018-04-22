//
//  Screen.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 22/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

public struct Screen {
    
    public static var size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    public static var pixelSize: CGSize {
        let screenSize = UIScreen.main.bounds.size
        let scale = UIScreen.main.scale
        
        return CGSize(width: screenSize.width * scale,
                      height: screenSize.height * scale)
    }
}
