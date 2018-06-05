//
//  Country.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 03/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Country {
    var country = ""
    var score = ""
    var adversaire = [String : Any]()
    
    
    // MARK: - Life cycle
    init() {
        self.loadData()
    }
    
    // MARK: -
    func loadData() {
        var reference: FIRDatabaseReference = FIRDatabase.database().reference().child(self.country)
            
        reference.observe(.value) { (snapshot) in
                for artists in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    
                    
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
