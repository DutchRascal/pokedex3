//
//  Pokemon.swift
//  pokedex3
//
//  Created by Andre Boevink on 04/02/2017.
//  Copyright © 2017 Andre Boevink. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    
    init(name:String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownLoadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    self._type = ""
                    
                    if types.count > 0 {
                        for x in 0..<types.count {
                            if let name = types[x]["name"] {
                                if x > 0 {
                                    self._type! += "/"
                                    
                                }
                                self._type! += "\(name.capitalized)"
                            }
                        }
                    }
                }
                
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>] , descriptionArray.count > 0 {
                    self._description = ""
                    if let url = descriptionArray[0]["resource_uri"] {
                        let descURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descURL).responseJSON { response in
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                if let description = descDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                                
                                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>] , evolutions.count > 0 {
                                    if let nextEvolution = evolutions[0]["to"] as? String {
                                        if nextEvolution.range(of: "mega") == nil {
                                            self._nextEvolutionName = nextEvolution
                                            if let url = evolutions[0]["resource_uri"] as? String {
                                                let newString = url.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                                let nextEvolutionId = newString.replacingOccurrences(of: "/", with: "")
                                                self._nextEvolutionId = nextEvolutionId
                                                if let levelExist = evolutions[0]["level"] {
                                                    if let level = levelExist as? Int {
                                                        self._nextEvolutionLevel = "\(level)"
                                                    }
                                                } else {
                                                    self._nextEvolutionLevel = ""
                                                }
                                            }
                                        }
                                    }
                                    print(self.nextEvolutionLevel)
                                    print(self.nextEvolutionName)
                                    print(self.nextEvolutionId)
                                }
                                
                            }
                            completed()
                        }
                    }
                }
            }
            
            completed()
        }
        
    }
}
