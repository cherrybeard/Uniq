//
//  HolyLightSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class HolyLightSpell: SpellCard {
    static private let damage: Int = 4
    
    init() {
        super.init(
            name: "Holy Light",
            spotsFilter: SpotsFilters.creatures
        )
        description = """
            Heals \(HolyLightSpell.damage) to selected target. If it is already at full health, \
            damage him instead.
        """
        /*
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                if creature.isDamaged {
                    battle.heal(HolyLightSpell.damage, to: spot!)
                } else {
                    battle.dealDamage(HolyLightSpell.damage, to: spot!)
                }
                return true
            }
            return false
        }
        */
    }
}
