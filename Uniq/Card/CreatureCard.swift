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
    var hasActiveAbility: Bool = false
    
    init(cost: Int, attack: Int, health: Int) {
        self.attack = attack
        self.health = health
        super.init(cost: cost)
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CharacterSprite? = nil) {  // OBSOLETE
        let creature = CreatureSprite(creature: self, owner: owner)
        battle.summon(creature)
    }
    
    override func generateSprite() -> CreatureCardSprite {
        return CreatureCardSprite(card: self)
    }
    
    func battlecry(battle: Battle, creature: CreatureSprite) {
        
    }
    
    func deathrattle(battle: Battle, creature: CreatureSprite) {
        
    }
    
    func useActiveAbility(battle: Battle) {
        
    }
}
