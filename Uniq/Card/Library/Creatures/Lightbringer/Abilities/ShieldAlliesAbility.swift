//
//  ShieldAlliesAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 16/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ShieldAlliesAbility: ActiveAbility {
    
    init(armor: Int) {
        super.init(
            name: "Shield allies",
            description: "Taunt. Increase all allies armor by 2.",
            cooldown: Cooldown(1),
            effect: { (battle: Battle, creature: Creature, target: Character?) in
                //battle.dealDamage(target)
            }
        )
    }
    
}
