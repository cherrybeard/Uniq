//
//  Hero.swift
//  Uniq
//
//  Created by Steven Gusev on 06/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class Hero: Character {
    var deck: Deck
    
    init() {
        deck = Deck(name: "NotOnlyDamageSpells")
        super.init(
            name: "Hero",
            health: Value(16)
        )
    }
    
    override func generateSprite() -> CharacterSprite {
        return HeroSprite(self)
    }
}
