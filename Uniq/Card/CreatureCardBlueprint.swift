//
//  CreatureCard.swift
//  Uniq
//
//  Created by Steven Gusev on 18/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class CreatureCardBlueprint: CardBlueprint {
    var attack: Int
    var health: Int
    var activeAbility: ActiveAbility? = nil
    
    init(description: String = "", attack: Int, health: Int, activeAbility: ActiveAbility? = nil) {
        self.attack = attack
        self.health = health
        self.activeAbility = activeAbility
        super.init(description: description)
    }
    
    override func generateSprite() -> CreatureCard {
        return CreatureCard(blueprint: self)
    }
    
    override func copy() -> CardBlueprint {
        let blueprint = CreatureCardBlueprint(
            description: description,
            attack: attack,
            health: health,
            activeAbility: activeAbility
        )
        return blueprint
    }
}
