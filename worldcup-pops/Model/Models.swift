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

class Team  {
    var name = ""
    var shortName = ""
    var id = 0
    
    init(_ name: String, _ shortName: String, _ id: Int) {
        self.name = name
        self.shortName = shortName
        self.id = id
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
    
    init(_ awayTeam: Int, _ homeTeam: Int, _ date: String, _ stadium: Int, _ group: String, _ step: String, _ awayScore: Int?, _ homeScore: Int?) {
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from:date)
        self.date = s
        
        self.stadium = stadium
        self.step = step
        self.group = group
        self.awayScore = awayScore
        self.homeScore = homeScore
    }
}

class Stadium {
    var name = ""
    var city = ""
    var id = 0
    
    init (_ name: String,_ city: String, _ id: Int) {
        self.name = ""
        self.city = ""
        self.id = id
    }
}

class Bet {
    var userid = ""
    var userName = ""
    var date = ""
    var homeTeam = 0
    var homeScore = 0
    var homePen = 0
    var awayTeam = 0
    var awayScore = 0
    var awayPen = 0
    
    init(_ userid: String, _ userName: String, _ date: String, _ homeTeam: Int, _ homeScore: Int, _ homePen: Int, _ awayTeam: Int, _ awayScore: Int, _ awayPen: Int) {
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


