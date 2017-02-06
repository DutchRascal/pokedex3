//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Andre Boevink on 06/02/2017.
//  Copyright © 2017 Andre Boevink. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalized
    }

}
