//
//  SWAPIClient.swift
//  TheAPIAwakens
//
//  Created by Bill Merickel on 12/18/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

enum Object: Endpoint {
    case Person
    case Starship
    case Vehicle
    
    var baseURL: NSURL {
        return NSURL(string: "http://swapi.co/api/")!
    }
    
    var path: String {
        switch self {
        case .Person: return "people/"
        case .Starship: return "starships/"
        case .Vehicle: return "vehicles/"
        }
    }
    
    var request: NSURLRequest {
        let url = NSURL(string: path, relativeToURL: baseURL)!
        return NSURLRequest(URL: url)
    }
}

final class StarWarsAPI: APIClient {
    
    let configuration: NSURLSessionConfiguration
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    init(config: NSURLSessionConfiguration) {
        self.configuration = config
    }
    
    convenience init() {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration())
    }
    
    func fetchPersonData(object: Object, completion: APIResult<[SWPerson]> -> Void) {
        let request = object.request
        var pageNumber = 1
        fetch(request, parse: { json in
            var SWPeople = [SWPerson]()
            var count = 0

            
            if let json = json as? [String: AnyObject] {
                if let number = json["count"] as? String {
                    count = Int(number)!
                }
                if pageNumber == 1 {
                    if let people = json["results"] as? [[String: AnyObject]] {
                        for person in people {
                            if let newSWPerson = SWPerson(JSON: person) {
                                SWPeople.append(newSWPerson)
                                count -= 1
                            }
                        }
                        pageNumber += 1
                    }
                }
                
            } else {
                //TODO: Errors
                print("Initialization failed")
            }

            
            return SWPeople
        }, completion: completion)
    }
    
    func fetchStarshipData(object: Object, completion: APIResult<[SWStarship]> -> Void) {
        let request = object.request
        var pageNumber = 1
        fetch(request, parse: { json in
            var SWStarships = [SWStarship]()
            var count = 0
            
            
            if let json = json as? [String: AnyObject] {
                if let number = json["count"] as? String {
                    count = Int(number)!
                }
                if pageNumber == 1 {
                    if let starships = json["results"] as? [[String: AnyObject]] {
                        for starship in starships {
                            if let newSWStarship = SWStarship(JSON: starship) {
                                SWStarships.append(newSWStarship)
                                count -= 1
                            }
                        }
                        pageNumber += 1
                    }
                }
                
            } else {
                //TODO: Errors
                print("Initialization failed")
            }
            
            
            return SWStarships
            }, completion: completion)
    }

    func fetchVehicleData(object: Object, completion: APIResult<[SWVehicle]> -> Void) {
        let request = object.request
        var pageNumber = 1
        fetch(request, parse: { json in
            var SWVehicles = [SWVehicle]()
            var count = 0
            
            
            if let json = json as? [String: AnyObject] {
                if let number = json["count"] as? String {
                    count = Int(number)!
                }
                if pageNumber == 1 {
                    if let vehicles = json["results"] as? [[String: AnyObject]] {
                        for vehicle in vehicles {
                            if let newSWVehicle = SWVehicle(JSON: vehicle) {
                                SWVehicles.append(newSWVehicle)
                                count -= 1
                            }
                        }
                        pageNumber += 1
                    }
                }
                
            } else {
                //TODO: Errors
                print("Initialization failed")
            }
            
            
            return SWVehicles
            }, completion: completion)
    }

}
