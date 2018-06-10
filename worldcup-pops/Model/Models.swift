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
    var parieur: String?
    var score: String?
    var winner: String?
    
    init() {
        
    }
    
}


