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
        var urlStr = BASE_URL_FUTBAL + ALL_COUNTRIES
    }
    
    func getAllOrganizations(for country: String, completion: @escaping CompletionHandStrings) {
        let urlOrgs = formURLAllOrganizations(for: country)
        var urlStr = BASE_URL_FUTBAL + urlOrgs
        
    }
    
    func getAllTeamsByViews(completion: @escaping CompletionHandTeams) {
        let urlStr = BASE_URL_FUTBAL + ALL_TEAMS_BY_VIEWS
        let url = URL(string: urlStr)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let retrievedData = data else {
                print(data!)
                return
            }
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else { return }
                if (jsonData["message"] as? String == "Success") {
                    guard let teams = jsonData["teams"] as? [NSDictionary] else { return }
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
