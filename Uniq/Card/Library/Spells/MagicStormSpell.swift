//
//  MagicStormSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class MagicStormSpell: SpellCard {
    static private let damage: Int = 2
    static private let times: Int = 4
    
    init() {
        super.init(name: "Magic Storm")
        description = "Deals \(MagicStormSpell.damage) damage to \(MagicStormSpell.times) random targets."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            for _ in 1...MagicStormSpell.times {
                if let target = battle.spots.randomSpot(in: SpotsFilters.creatures) {
                    battle.dealDamage(MagicStormSpell.damage, to: target)
                    battle.wait(for: 1)
                }
            }
            return true
        }
    }
}
