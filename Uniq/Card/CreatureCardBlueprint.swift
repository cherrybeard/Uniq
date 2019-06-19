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
    var ability: ActiveAbility? = nil
    var whenSummoned: PassiveAbility? = nil
    var onSummon: PassiveAbility? = nil
    
    init(
        description: String = "",
        attack: Int,
        health: Int,
        whenSummoned: PassiveAbility? = nil,
        ability: ActiveAbility? = nil,
        onSummon: PassiveAbility? = nil
    ) {
        self.attack = attack
        self.health = health
        self.whenSummoned = whenSummoned
        self.ability = ability
        super.init(
            description: description,
            requiresTarget: true,
            spotsFilter: SpotsFilters.ownerFree
        )
    }
    
    override func generateSprite() -> CreatureCard {
        return CreatureCard(blueprint: self)
    }
    
    override func play(battle: Battle, spot: Spot?) -> Bool {
        if spot != nil {
            battle.summon(self, to: spot!)
            return true
        }
        return false
    }
    
    override func copy() -> CardBlueprint {
        let blueprint = CreatureCardBlueprint(
            description: description,
            attack: attack,
            health: health,
            ability: ability
        )
        return blueprint
    }
}
