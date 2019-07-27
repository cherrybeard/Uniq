//
//  AttackAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class AttackAbility: ActiveAbility {
    
    init(name: String = "Attack", damage: Int) {
        super.init(
            name: name,
            description: "Deal \(damage) damage to a single enemy.",
            cooldown: Cooldown(1),
            effect: { (battle: Battle, target: Character?) in
                if let target = target {
                    battle.dealDamage(damage, to: target) // TODO: replace with .attack()
                }
            },
            targetFilter: CharacterFilters.enemy
        )
    }
    
}
