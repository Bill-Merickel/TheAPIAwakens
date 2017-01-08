//
//  SWAPIModels.swift
//  TheAPIAwakens
//
//  Created by Bill Merickel on 12/18/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

enum ObjectErrors: ErrorType {
    case IncompleteInitialization(String)
    case N
}

func getHomeworld(homeworld: String) -> String {
    
    var homeworldName: String = ""
    let homeworldURL = NSURL(string: homeworld)!
    let request = NSURLRequest(URL: homeworldURL)
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    let task = session.dataTaskWithRequest(request) { data, response, error in
        if error == nil {
            let response = response as? NSHTTPURLResponse
            switch response!.statusCode {
            case 200:
                do {
                    if data != nil {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject]
                        if let planetName = json!["name"] as? String {
                            homeworldName = planetName
                        }
                    }
                } catch let error {
                    print(error)
                }
            default: break
            }
        }
    }
    
    task.resume()
    return homeworldName
}

public struct SWPerson {
    let name: String
    let birthYear: String
    let eyeColor: String
    let hairColor: String
    let height: Int
    var homeworld: String
}

extension SWPerson: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let name = JSON["name"] as? String,
        let birthyear = JSON["birth_year"] as? String,
        let eyeColor = JSON["eye_color"] as? String,
        let hairColor = JSON["hair_color"] as? String,
        let height = JSON["height"] as? String,
        let homeworld = JSON["homeworld"] as? String else {
            return nil
        }
        
        self.name = name
        self.birthYear = birthyear
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.height = Int(height)!
        self.homeworld = homeworld
        
        let homeworldURL = NSURL(string: homeworld)!
        let request = NSURLRequest(URL: homeworldURL)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error == nil {
                let response = response as? NSHTTPURLResponse
                switch response!.statusCode {
                case 200:
                    do {
                        if data != nil {
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                            if let planetName = json!["name"] as? String {
                                self.homeworld = planetName
                            } else {
                                print("No name")
                            }
                        } else {
                            print("No data")
                        }
                    } catch let error {
                        print(error)
                    }
                default: break
                }
            }
        }
        
        task.resume()

    }
}

public struct SWStarship: JSONDecodable {
    let name: String
    let make: String
    let cost: String
    let length: String
    let starshipClass: String
    let crew: Int
    
    init?(JSON: [String : AnyObject]) {
        guard let name = JSON["name"] as? String,
            let make = JSON["model"] as? String,
            let cost = JSON["cost_in_credits"] as? String,
            let length = JSON["length"] as? String,
            let starshipClass = JSON["starship_class"] as? String,
            let crew = JSON["crew"] as? String else {
                return nil
        }
        
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.starshipClass = starshipClass
        self.crew = Int(crew)!
    }
}

public struct SWVehicle: JSONDecodable {
    let name: String
    let make: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crew: String
    
    init?(JSON: [String : AnyObject]) {
        guard let name = JSON["name"] as? String,
            let make = JSON["model"] as? String,
            let cost = JSON["cost_in_credits"] as? String,
            let length = JSON["length"] as? String,
            let vehicleClass = JSON["vehicle_class"] as? String,
            let crew = JSON["crew"] as? String else {
                return nil
        }
        
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
    }
}
