//
//  Country.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 03/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class Country {
    var country = ""
    var score = ""
    var countries = [String : Any]()
    
    
    // MARK: - Life cycle
    init() {
        self.loadData()
    }
    
    
    // MARK: - Firebase
    func loadData() {
        for (index, country) in Constants.countries.enumerated() {
        var reference: FIRDatabaseReference = FIRDatabase.database().reference().child("country\(index)")
            log.debugMessage("😱😱😱😱")
        reference.observe(.value) { (snapshot) in
                for artists in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    
                    self.countries[country] = artists.children.allObjects as! [Any]
                    log.debugMessage("countries ---- : \(self.countries)")
                    for artist in artists.children.allObjects as! [FIRDataSnapshot] {
                        let country = artist.value as? [String : Any]
                        log.debugMessage("🙁 \(country!["adversaire"])")
                    }
                    
                    log.debugMessage("adversaire: \(artists)")
                    //getting values
                    let country = artists.value as? [String]
                    log.debugMessage("country: \(country)")
                    
                }
            }
        }
    }
}

class Teams {
    var name = ""
    var shortName = ""
    var id = 0
    let reference = FIRDatabase.database().reference().child("teams")
    
    init() {
        self.loadData()
    }
    
    func loadData() {
        reference.observe(.value) { (snapshot) in
            for elements in snapshot.children.allObjects as! [FIRDataSnapshot] {
                for element in elements.children.allObjects as! [FIRDataSnapshot] {
                log.debugMessage("element: \(element)")
                if element.key == "name" {
                    self.name = element.value as! String
                }
                log.debugMessage("🐈 \(self.name)")
//                else if element.key == "poule" {
//                    self.poule = element.value as! String
//                }
//                else if element.key == "matches" {
//                    //self.matches.append(Match(
                }
            }
        }
    }
    
    
}


class Country2 {
    var name: String = ""
    var poule: String = ""
    var matches = Array<Match>()
    var reference: FIRDatabaseReference
    
    // MARK: - Life cycle
    init(_ ref: FIRDatabaseReference) {
        self.reference = ref
        self.loadData()
    }
    
    func loadData() {
        reference.observe(.value) { (snapshot) in
            for element in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if element.key == "country" {
                    self.name = element.value as! String
                }
                else if element.key == "poule" {
                    self.poule = element.value as! String
                }
                else if element.key == "matches" {
                    //self.matches.append(Match(element.ref))
                }
            }
            log.debugMessage("PAYS: \(self.name)")
        }
    }
//    constructor(dataSnapshot: DataSnapshot) {
//    name = dataSnapshot.child("country").getValue(String::class.java)
//    poule = dataSnapshot.child("poule").getValue(String::class.java)
//
//    if (dataSnapshot.child("matchs").childrenCount > 0) {
//    for (match in dataSnapshot.child("matchs").children) {
//    matches.add(Match(match))
//    }
//    }
//
//    }
    
}


class Match {
    var opponent: String?
    var score: String?
    var bets = Array<Bet>()
    var reference: FIRDatabaseReference
    
    init(_ ref: FIRDatabaseReference) {
        self.reference = ref
        self.loadData()
    }
    
    func loadData() {
        self.reference.observe(.value) { (snapshot) in
            for element in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let match = element.value as? [String : Any]
                if let oppoenent = match?["adversaire"] as? String { self.opponent = oppoenent }
                if let score = match?["score"] as? String { self.score = score }
//                for match in country.children.allObjects as! [FIRDataSnapshot] {
//                    self.matches.append(Match(match.ref))
//                }
            }
        }
    }
    
//    constructor(dataSnapshot: DataSnapshot) {
//    opponent = dataSnapshot.child("adversaire").getValue(String::class.java)
//    score = dataSnapshot.child("score").getValue(String::class.java)
//
//    if (dataSnapshot.child("bets").childrenCount > 0) {
//    for (bet in dataSnapshot.child("bets").children) {
//    bets.add(Bet(bet))
//    }
//    }
//    }
//
}

class Bet {
    var parieur: String?
    var score: String?
    var winner: String?
    
//    constructor(dataSnapshot: DataSnapshot) {
//    parieur = dataSnapshot.child("parieur").getValue(String::class.java)
//    score = dataSnapshot.child("score").getValue(String::class.java)
//    winner = dataSnapshot.child("winner").getValue(String::class.java)
//    }
    
}


