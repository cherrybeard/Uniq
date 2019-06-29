//
//  TakingAimSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class TakingAimSpell: SpellCard {
    static private let damage: Int = 1
    
    init() {
        super.init(
            name: "Taking Aim",   // "Spark" is good name too
            requiresTarget: true,
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = "Deal \(TakingAimSpell.damage) damage to selected target and draw a card."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if spot != nil {
                battle.dealDamage(TakingAimSpell.damage, to: spot!)
                _ = battle.draw(for: battle.activePlayer)
                return true
            }
            return false
        }
    }
}
