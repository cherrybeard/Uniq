//
//  CreatureCard.swift
//  Uniq
//
//  Created by Steven Gusev on 18/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class CreatureCard: Card {
    var attack: Int
    var health: Int
    var activeAbility: ActiveAbility? = nil
    
    init(description: String = "", attack: Int, health: Int, activeAbility: ActiveAbility? = nil) {
        self.attack = attack
        self.health = health
        self.activeAbility = activeAbility
        super.init(description: description)
    }
    
    override func generateSprite() -> CreatureCardSprite {
        return CreatureCardSprite(card: self)
    }
    
    override func copy() -> Card {
        let card = CreatureCard(
            description: description,
            attack: attack,
            health: health,
            activeAbility: activeAbility
        )
        return card
    }
}
