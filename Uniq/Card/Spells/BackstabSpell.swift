//
//  BackstabSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BackstabSpell: SpellCard {
    static private let damage: Int = 8
    
    init() {
        super.init(
            name: "Backstab",
            requiresTarget: true,
            spotsFilter: {
                !$0.owner.isActive && ($0.creature != nil) && ($0.creature?.health == $0.creature?.maxHealth)
            }
        )
        description = "Deals \(BackstabSpell.damage) damage to undamaged creature."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if spot != nil {
                battle.dealDamage(BackstabSpell.damage, to: spot!)
                return true
            }
            return false
        }
    }
}