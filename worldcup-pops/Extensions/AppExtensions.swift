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
