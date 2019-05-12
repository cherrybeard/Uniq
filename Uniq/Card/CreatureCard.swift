//
//  CreatureCard.swift
//  Uniq
//
//  Created by Steven Gusev on 18/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class CreatureCard: Card {
    weak var summon: CreatureSprite? = nil
    
    var attack: Int
    var health: Int
    var charge: Bool = false
    var activeAbilityCooldown: Int = -1
    
    init(attack: Int, health: Int) {
        self.attack = attack
        self.health = health
        super.init()
    }
    
    override func generateSprite() -> CreatureCardSprite {
        return CreatureCardSprite(card: self)
    }
    
    func battlecry(battle: Battle, creature: CreatureSprite) {
        
    }
    
    func deathrattle(battle: Battle, creature: CreatureSprite) {
        
    }
    
    func useActiveAbility(battle: Battle) {
        // TODO: Rework into singgle ActiveAbilityty structure
        // TOOD: Add -> Bool to check if it was really used or maybe some way to check available targets
    }
}
