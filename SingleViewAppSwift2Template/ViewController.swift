//
//  ViewController.swift
//  SingleViewAppSwift2Template//  Created by Treehouse on 9/19/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
//

import UIKit 
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swapi = StarWarsAPI()
        let person = Object.Person
        let starship = Object.Starship
        let vehicle = Object.Vehicle
        
        swapi.fetchPersonData(person) { result in
            switch result {
            case .Success(let listOfPeople): print(listOfPeople); print(listOfPeople.count)
            default: break
            }
        }
        swapi.fetchStarshipData(starship) { result in
            switch result {
            case .Success(let listOfPeople): print(listOfPeople); print(listOfPeople.count)
            default: break
            }
        }
        swapi.fetchVehicleData(vehicle) { result in
            switch result {
            case .Success(let vehicles): print(vehicles)
            default: break
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

