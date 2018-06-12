//
//  AppExtensions.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 11/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit

extension Date
{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "fr")
        return dateFormatter.string(from: self)
    }
}

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}

extension String {
    func customTextAttributes(_ start: String, _ end: String) ->  NSMutableAttributedString {
        let startAttribute = NSMutableAttributedString(string: start, attributes: [NSAttributedStringKey.font : UIFont.circularStdMedium(20.0), NSAttributedStringKey.foregroundColor : UIColor.white])
        let endAttribute = NSMutableAttributedString(string: end, attributes: [NSAttributedStringKey.font : UIFont.circularStdBook(12.0), NSAttributedStringKey.foregroundColor : UIColor.white])
        
        startAttribute.append(endAttribute)
        
        return startAttribute
    }
}
