//
//  AttackAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class AttackAbility: ActiveAbility {
    
    init(damage: Int) {
        super.init(
            name: "Attack",
            description: "Deals damage to single enemy",
            cooldown: 1,
            effect: { (battle: Battle, target: Character?) in
                //battle.dealDamage(target)
            }
        )
    }
    
}
