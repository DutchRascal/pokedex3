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

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvolutionImage.image = image
        pokedexLabel.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetail {
            
             // Whatever we write will only be called after the network call is complete!
            self.updateUI()
            
        }
    }
    
    func updateUI() {
        
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    
    }
}
