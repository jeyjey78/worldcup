//
//  UIDeviceExtensions.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 24/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    public enum DeviceType {
        case iPhone4
        case iPhone5
        case iPhoneSE
        case iPhone6
        case iPhone6Plus
        case iPhone7
        case iPhone7Plus
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPad
        case unknown
    }
    
    public var type: DeviceType {
        guard userInterfaceIdiom == .phone else {
            return .iPad
        }
        
        let result: DeviceType
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     result = .iPhone4
        case "iPhone4,1":                               result = .iPhone4       // iPhone 4s
        case "iPhone5,1", "iPhone5,2":                  result = .iPhone5
        case "iPhone5,3", "iPhone5,4":                  result = .iPhone5       // iPhone 5c
        case "iPhone6,1", "iPhone6,2":                  result = .iPhone5       // iPhone 5s
        case "iPhone7,2":                               result = .iPhone6
        case "iPhone7,1":                               result = .iPhone6Plus
        case "iPhone8,1":                               result = .iPhone6       // iPhone 6s
        case "iPhone8,2":                               result = .iPhone6Plus   // iPhone 6s Plus
        case "iPhone8,4":                               result = .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                  result = .iPhone7       // iPhone 7
        case "iPhone9,2", "iPhone9,4":                  result = .iPhone7Plus   // iPhone 7 Plus
        case "iPhone10,1", "iPhone10,4":                result = .iPhone8       // iPhone 8
        case "iPhone10,2", "iPhone10,5":                result = .iPhone8Plus   // iPhone 8 Plus
        case "iPhone10,3", "iPhone10,6":                result = .iPhoneX       // iPhone X
        default:                                        result = .unknown
        }
        
        return result
    }
    
    public static func isPhone() -> Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    public static func isPad() -> Bool {
        return UIDevice().userInterfaceIdiom == .pad
    }
}
