//
//  ProfileFlow.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 22/04/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfileFlow: Flow {
    
    private var rootFlow: UIViewController!
    
    var navigation: ProfileNavigationController!
    var appFlowDelegate: AppFlowDelegate?
    var teams: [Team] = []
    var matchs: [Match] = []
    var stadiums: [Stadium] = []
    var bets: [Bet] = []
    var users: [User] = []
    var userId = ""
    
    init () {
        let shopController = ProfileViewController(self)
        shopController.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // userId
        let defaults = UserDefaults.standard
        self.userId = defaults.object(forKey: Constants.firebaseId) as! String
        
        self.navigation = ProfileNavigationController(rootViewController: shopController)
        
        self.loadUsers()
    }
    
    func start() -> UIViewController {
        
        return self.navigation
    }
    
    // MARK: - Firebase
    func loadUsers() {
        self.users = []
        
        if let controller = self.navigation.visibleViewController as? ProfileViewController {
            controller.playLoader = true
            controller.refreshButton.isEnabled = false
        }
        
        let reference: FIRDatabaseReference = FIRDatabase.database().reference().child("users")
        reference.observeSingleEvent(of: .value) { (snapshot) in
            for elements in snapshot.children.allObjects as! [FIRDataSnapshot] {
                var username = ""
                var points = 0
                let id = elements.key
                
                for element in elements.children.allObjects as! [FIRDataSnapshot] {
                    if element.key == "user_name" {
                        username = element.value as! String
                    }
                    if element.key == "points" {
                        points = element.value as! Int
                    }
                }
                
                let user = User(username, points, id)
                self.users.append(user)
                
            }
            
            self.loadTeams()
        }
    }
    
    func loadTeams() {
        self.teams = []
        let reference: FIRDatabaseReference = FIRDatabase.database().reference().child("teams")
        reference.observeSingleEvent(of: .value) { (snapshot) in
            for elements in snapshot.children.allObjects as! [FIRDataSnapshot] {
                var name = ""
                var shortName = ""
                var group = ""
                var id = 0
                
                for element in elements.children.allObjects as! [FIRDataSnapshot] {
                    if element.key == "name" {
                        name = element.value as! String
                    }
                    if element.key == "fifaCode" {
                        shortName = element.value as! String
                    }
                    if element.key == "id" {
                        id = element.value as! Int
                    }
                    if element.key == "group" {
                        group = element.value as! String
                    }
                }
                
                let team = Team(name, shortName, id, group)
                self.teams.append(team)
                
            }
            
            self.loadMatchs()
        }
    }
    
    func loadMatchs() {
        self.matchs = []
        let reference: FIRDatabaseReference = FIRDatabase.database().reference().child("groups")
        reference.observeSingleEvent(of: .value) { (snapshot) in
            for elements in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let group = elements.key
                let step = "poule"
                
                // In group
                //let element = elements.childSnapshot(forPath: "matches")
                    
                    // Matches by group
                    for matches in elements.children.allObjects as! [FIRDataSnapshot] {
                        var away = 0
                        var home = 0
                        var date = ""
                        var stadium = 0

                        // Each match
                       
                        for match in matches .children.allObjects as! [FIRDataSnapshot] {
                            var awayScore: Int?
                            var homeScore: Int?
                            var awayPen: Int?
                            var homePen: Int?
                            for elemMatch in match.children.allObjects as! [FIRDataSnapshot] {
                                if elemMatch.key == "away_team" {
                                    away = elemMatch.value as! Int
                                }
                                if elemMatch.key == "home_team" {
                                    home = elemMatch.value as! Int
                                }
                                if elemMatch.key == "date" {
                                    date = elemMatch.value as! String
                                }
                                if elemMatch.key == "stadium" {
                                    stadium = elemMatch.value as! Int
                                }
                                if elemMatch.key == "away_score" {
                                    awayScore = elemMatch.value as? Int
                                }
                                if elemMatch.key == "home_score" {
                                    homeScore = elemMatch.value as? Int
                                }
                                if elemMatch.key == "away_pen" {
                                    awayPen = elemMatch.value as? Int
                                }
                                if elemMatch.key == "home_pen" {
                                    homePen = elemMatch.value as? Int
                                }
                            }
                            
                            let match = Match(away, home, date, stadium, group, step, awayScore, homeScore, awayPen, homePen)
                            self.matchs.append(match)
                        }
                    }
            }
            
             self.loadKnockout()
        }
    }
    
    func loadKnockout() {
        let reference: FIRDatabaseReference = FIRDatabase.database().reference().child("knockout")
        reference.observeSingleEvent(of: .value) { (snapshot) in
            for elements in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let group = ""
                let step = elements.key
                // In group
                
                //let element = elements.childSnapshot(forPath: "matches")
                
                // Matches by group
                for matches in elements.children.allObjects as! [FIRDataSnapshot] {
                    var away = 0
                    var home = 0
                    var date = ""
                    var stadium = 0
                    
                    // Each match
                    
                    for match in matches .children.allObjects as! [FIRDataSnapshot] {
                        var awayScore: Int?
                        var homeScore: Int?
                        var awayPen: Int?
                        var homePen: Int?
                        for elemMatch in match.children.allObjects as! [FIRDataSnapshot] {
                            if elemMatch.key == "away_team" {
                                away = ((elemMatch.value as? Int) != nil) ? elemMatch.value as! Int  : 0
                            }
                            if elemMatch.key == "home_team" {
                                home = ((elemMatch.value as? Int) != nil) ? elemMatch.value as! Int  : 0
                            }
                            if elemMatch.key == "date" {
                                date = elemMatch.value as! String
                            }
                            if elemMatch.key == "stadium" {
                                stadium = elemMatch.value as! Int
                            }
                            if elemMatch.key == "away_score" {
                                awayScore = elemMatch.value as? Int
                            }
                            if elemMatch.key == "home_score" {
                                homeScore = elemMatch.value as? Int
                            }
                            if elemMatch.key == "away_pen" {
                                awayPen = elemMatch.value as? Int
                            }
                            if elemMatch.key == "home_pen" {
                                homePen = elemMatch.value as? Int
                            }
                        }
                        
                        let match = Match(away, home, date, stadium, group, step, awayScore, homeScore, awayPen, homePen)
                        self.matchs.append(match)
                    }
                }
            }
            
            self.loadStadium()
        }
    }
    
    func loadStadium() {
        self.stadiums = []
        let reference: FIRDatabaseReference = FIRDatabase.database().reference().child("stadiums")
        reference.observeSingleEvent(of: .value) { (snapshot) in
            for elements in snapshot.children.allObjects as! [FIRDataSnapshot] {
                var name = ""
                var city = ""
                var id = 0
               
                for element in elements.children.allObjects as! [FIRDataSnapshot] {
                    if element.key == "name" {
                        name = element.value as! String
                    }
                    if element.key == "city" {
                        city = element.value as! String
                    }
                    if element.key == "id" {
                        id = element.value as! Int
                    }
                }
                
                let stadium = Stadium(name, city, id)
                self.stadiums.append(stadium)
                
            }
            
            self.loadBets()
        }
    }
    
    func loadBets() {
        self.bets = []
        let reference: FIRDatabaseReference = FIRDatabase.database().reference().child("bets")
        reference.observeSingleEvent(of: .value) { (snapshot) in
            for elements in snapshot.children.allObjects as! [FIRDataSnapshot] {
                var userid = ""
                var userName = ""
                var date = ""
                var homeTeam = 0
                var homeScore = 0
                var homePen: Int?
                var awayTeam = 0
                var awayScore = 0
                var awayPen: Int?
                
                for element in elements.children.allObjects as! [FIRDataSnapshot] {
                    if element.key == "user_id" {
                        userid = element.value as! String
                    }
                    if element.key == "user_name" {
                        userName = element.value as! String
                    }
                    if element.key == "date" {
                        date = element.value as! String
                    }
                    if element.key == "home_team" {
                        homeTeam = element.value as! Int
                    }
                    if element.key == "home_score" {
                        homeScore = element.value as! Int
                    }
                    if element.key == "home_pen" {
                        homePen = element.value as? Int
                    }
                    if element.key == "away_team" {
                        awayTeam = element.value as! Int
                    }
                    if element.key == "away_score" {
                        awayScore = element.value as! Int
                    }
                    if element.key == "away_pen" {
                        awayPen = element.value as? Int
                    }
                }
                
                let bet = Bet(userid, userName, date, homeTeam, homeScore, homePen, awayTeam, awayScore, awayPen)
                self.bets.append(bet)
            }
            
            if let controller = self.navigation.visibleViewController as? ProfileViewController {
                controller.playLoader = false
                controller.refreshButton.isEnabled = true
            }
            
            self.updatePoints()
        }
    }

}


// MARK: - Protocol
protocol ProfileFlowDelegate {
    
    func continueToCountries(_ controller: UIViewController)
    func continueToUsers(_ controller: UIViewController)
    func continueToOwnerBet(_ controller: UIViewController)
    func continueToMatch(_ controller: UIViewController, match: Match)
    func continueToMatchCountry(_ controller: UIViewController, countryId: Int)
    func continueToDayMatch(_ controller: UIViewController)
    func continueToSelectCountry()
    
    func saveUserCountry(_ country: String)
    func saveBet(_ controller: UIViewController, bet: Bet)
    func backProfile(_ controller: UIViewController)
    func backAction(_ controller: UIViewController)
    func closeAction()
    
    func reloadData()
}


// MARK: - AppFlow Delegate
extension ProfileFlow: ProfileFlowDelegate {
    
    // MARK: - Continue to
    func continueToCountries(_ controller: UIViewController) {
        let countriesController = CountriesViewController()
        countriesController.flowDelegate = self
        
        self.navigation.pushViewController(countriesController, animated: true)
    }
    
    func continueToUsers(_ controller: UIViewController) {
        let controller = UsersViewController()
        controller.flowDelegate = self
        
        self.navigation.pushViewController(controller, animated: true)
    }
    
    func continueToOwnerBet(_ controller: UIViewController) {
        let betController = BetViewController()
        betController.flowDelegate = self
        
        self.navigation.pushViewController(betController, animated: true)
    }
    
    func continueToMatch(_ controller: UIViewController, match: Match) {
        let matchController = MatchBetViewController(match)
        matchController.flowDelegate = self
        
        self.navigation.pushViewController(matchController, animated: true)
    }
    
    func continueToMatchCountry(_ controller: UIViewController, countryId: Int) {
        let matchController = MatchCountryViewController(countryId)
        matchController.flowDelegate = self
        
        self.navigation.pushViewController(matchController, animated: true)
    }
    
    func continueToAddBet(_ controller: UIViewController, match: Match) {
        let betController = AddBetViewController(match)
        betController.flowDelegate = self
        
        self.navigation.present(betController, animated: true, completion: nil)
    }
    
    func continueToDayMatch(_ controller: UIViewController) {
        let allmatchController = AllMatchsViewController()
        allmatchController.flowDelegate = self
        
        self.navigation.pushViewController(allmatchController, animated: true)
    }
    
    
    // User country
    func continueToSelectCountry() {
        let controller = SelectFavoriteCountryViewController()
        controller.flowDelegate = self
        
        self.navigation.present(controller, animated: true, completion: nil)
    }
    
    func saveUserCountry(_ country: String) {
        let defaults = UserDefaults.standard
        defaults.set(country, forKey: Constants.userCountry)
        
        if let controller = self.navigation.viewControllers.last as? ProfileViewController {
            controller.setProfilePicture()
        }
        
        self.navigation.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Bet
    func saveBet(_ controller: UIViewController, bet: Bet) {
        log.debugMessage("number of bets 2: \(self.bets.count)")
        self.loadBets()
        
        if let controller = self.navigation.viewControllers.last as? MatchBetViewController {
            controller.bets.append(bet)
            controller.updateBetButton()
            controller.collectionView.reloadData()
        }
        
        self.navigation.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Back
    func backProfile(_ controller: UIViewController) {
        self.navigation.popViewController(animated: true)
    }
    
    func backAction(_ controller: UIViewController) {
        self.navigation.popViewController(animated: true)
    }
    
    func closeAction() {
        self.navigation.dismiss(animated: true, completion: nil)
    }
    
    // Points
    func updatePoints() {
        var bets: [Bet] = []
        for bet in self.bets {
            if bet.userid == self.userId {
                bets.append(bet)
            }
        }
        
        var points = 0
        
        for match in self.matchs {
            for bet in bets {
                if match.homeTeam == bet.homeTeam && match.awayTeam == bet.awayTeam {
                    if let matchHomeScore = match.homeScore, let matchAwayScore = match.awayScore{
                        let matchHomePen = match.homePen ?? 0
                        let matchAwayPen = match.awayPen ?? 0
                        let betHomePen = bet.homePen ?? 0
                        let betAwayPen = bet.awayPen ?? 0
                        
                        if matchHomeScore + matchHomePen == bet.homeScore + betHomePen && matchAwayScore + matchAwayPen == bet.awayScore + betAwayPen {
                            points += 3
                        }
                        else if (matchHomeScore + matchHomePen > matchAwayScore + matchAwayPen && bet.homeScore + betHomePen  > bet.awayScore + betAwayPen) ||
                            (matchHomeScore + matchHomePen < matchAwayScore + matchAwayPen && bet.homeScore + betHomePen  < bet.awayScore + betAwayPen) ||
                            (matchHomeScore + matchHomePen == matchAwayScore + matchAwayPen && bet.homeScore + betHomePen  == bet.awayScore + betAwayPen) {
                            points += 1
                        }
                    }
                }
            }
        }
        
        if let controller = self.navigation.visibleViewController as? ProfileViewController {
            controller.userPoints = points
        }
        
        self.sendPoints(points)
    }
    
    func sendPoints(_ points: Int) {
        let reference: FIRDatabaseReference = FIRDatabase.database().reference().child("users").child(self.userId)
        let value = [
            "user_name": UserDefaults.standard.object(forKey: Constants.username) ?? "",
            "points": points] as [String: Any]
        
        reference.setValue(value)
        reference.removeAllObservers()
    }
    
    func reloadData() {
        self.loadUsers()
    }
}
