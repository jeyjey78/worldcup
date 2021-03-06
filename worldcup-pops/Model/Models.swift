//
//  Models.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 03/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class User  {
    var username = ""
    var points = 0
    var id = ""
    
    init(_ username: String, _ points: Int, _ id: String) {
        self.username = username
        self.points = points
        self.id = id
    }
}

class Team  {
    var name = ""
    var shortName = ""
    var group = ""
    var id = 0
    
    init(_ name: String, _ shortName: String, _ id: Int, _ group: String) {
        self.name = name
        self.shortName = shortName
        self.id = id
        self.group = group
    }
}


class Match {
    var awayTeam: Int!
    var homeTeam: Int!
    var date : Date!
    var stadium: Int!
    var group =  ""
    var step = ""
    var awayScore: Int?
    var homeScore: Int?
    var awayPen: Int?
    var homePen: Int?
    
    init(_ awayTeam: Int, _ homeTeam: Int, _ string: String, _ stadium: Int, _ group: String, _ step: String, _ awayScore: Int?, _ homeScore: Int?, _ awayPen: Int?, _ homePen: Int?) {
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        self.stadium = stadium
        self.step = step
        self.group = group
        self.awayScore = awayScore
        self.homeScore = homeScore
        self.awayPen = awayPen
        self.homePen = homePen
        
        //date
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        self.date = RFC3339DateFormatter.date(from: string)
        //date?.addTimeInterval(TimeInterval(3600 * 2))
    }
}


class Stadium {
    var name = ""
    var city = ""
    var id = 0
    
    init (_ name: String,_ city: String, _ id: Int) {
        self.name = name
        self.city = city
        self.id = id
    }
}


class Bet {
    var userid = ""
    var userName = ""
    var date = ""
    var homeTeam = 0
    var homeScore = 0
    var homePen: Int?
    var awayTeam = 0
    var awayScore = 0
    var awayPen: Int?
    
    init(_ userid: String, _ userName: String, _ date: String, _ homeTeam: Int, _ homeScore: Int, _ homePen: Int?, _ awayTeam: Int, _ awayScore: Int, _ awayPen: Int?) {
        self.userid = userid
        self.userName = userName
        self.date = date
        self.homeTeam = homeTeam
        self.homeScore = homeScore
        self.homePen = homePen
        self.awayTeam = awayTeam
        self.awayScore = awayScore
        self.awayPen = awayPen
    }
}


