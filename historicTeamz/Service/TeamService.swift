//
//  TeamService.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/21/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

class TeamService {
    
    static let instance = TeamService()
    
    func getAllCountries(completion: @escaping CompletionHandStrings) {
        let urlStr = BASE_URL_FUTBAL + ALL_COUNTRIES
        let url = URL(string: urlStr)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let retrievedData = data else { return }
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else { return }
                if let message = jsonData["message"] as? String {
                    if (message == "Success") {
                        guard let countries = jsonData["countries"] as? [String] else {
                            completion(false, [])
                            return
                        }
                        completion(true, countries)
                    }
                }
            } catch {
                print("Can't do get request: \(error), \(error.localizedDescription)")
                completion(false, [])
            }
        })
        
        task.resume()
    }
    
    func getAllOrganizations(for country: String, completion: @escaping CompletionHandStrings) {
        let countryStr = country.replacingOccurrences(of: " ", with: "%")
        let urlOrgs = formURLAllOrganizations(for: countryStr)
        let urlStr = BASE_URL_FUTBAL + urlOrgs
        let url = URL(string: urlStr)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard let retrievedData = data else {
                completion(false, [])
                return
            }
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else {
                    completion(false, [])
                    return
                }
                if let message = jsonData["message"] as? String {
                    if (message == "Success") {
                        guard let organizations = jsonData["organizations"] as? [String] else {
                            completion(false, [])
                            return
                        }
                        completion(true, organizations)
                    } else {
                        completion(false, [])
                    }
                }
            } catch {
                print("Can't do request: \(error) \(error.localizedDescription)")
                completion(false, [])
            }
        }
        
        task.resume()
    }
    
    func getAllTeams(for organization: String, completion: @escaping CompletionHandTeams) {
        let orgStr = organization.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlTeam = formURLAllTeams(for: orgStr!)
        let urlStr = BASE_URL_FUTBAL + urlTeam
        let url = URL(string: urlStr)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard let retrievedData = data else {
                completion(false, [])
                return
            }
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else {
                    completion(false, [])
                    return
                }
                if let message = jsonData["message"] as? String {
                    if message == "Success" {
                        guard let teams = jsonData["teams"] as? [NSDictionary] else {
                            completion(false, [])
                            return
                        }
                        completion(true, teams)
                    }
                }
            } catch {
                print("Can't do request: \(error), \(error.localizedDescription)")
                completion(false, [])
            }
        }
        
        task.resume()
    }
    
    func getAllTeamsByViews(completion: @escaping CompletionHandTeams) {
        let urlStr = BASE_URL_FUTBAL + ALL_TEAMS_BY_VIEWS
        let url = URL(string: urlStr)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let retrievedData = data else {
                completion(false, [])
                return
            }
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else { return }
                if (jsonData["message"] as? String == "Success") {
                    guard let teams = jsonData["teams"] as? [NSDictionary] else {
                        completion(false, [])
                        return
                    }
                    completion(true, teams)
                }
            } catch {
                print("Can't do get request: \(error), \(error.localizedDescription)")
                completion(false, [])
            }
        })
        
        task.resume()
    }
    
    
}
