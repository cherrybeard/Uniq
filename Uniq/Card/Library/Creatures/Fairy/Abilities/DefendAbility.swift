//
//  DefendAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class DefendAbility: ActiveAbility {
    
    init(armor: Int) {
        super.init(
            name: "Defend",
            description: "Gain 3 block.",
            cooldown: Cooldown(1),
            effect: { (battle: Battle, target: Character?) in
                //battle.dealDamage(target)
            }
        )
    }
    
}